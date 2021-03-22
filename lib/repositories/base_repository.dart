// ignore_for_file: close_sinks

import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pam_flutter/utils/requester.dart';
import 'package:rxdart/rxdart.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/mocks/banners/banners.dart';
import 'package:singh_architecture/mocks/carts/carts.dart';
import 'package:singh_architecture/mocks/categories/categories.dart';
import 'package:singh_architecture/mocks/notifications/notifications.dart';
import 'package:singh_architecture/mocks/products/product_detail.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/repositories/cart_repository.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/repositories/notification_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/object_helper.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class BaseDataRepository<T> implements IBaseDataRepository {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;
  String _errorMessage = "";
  List<dynamic>? _items;
  dynamic? _data;

  late StreamController<bool> _isLoadingSC;
  late StreamController<bool> _isLoadedSC;
  late StreamController<bool> _isErrorSC;
  late StreamController<String> _errorMessageSC;
  late StreamController<List<T>?> _itemsSC;
  late StreamController<T?> _dataSC;

  BaseDataRepository(
    this.buildCtx,
    this.config,
    this.options,
  ) {
    this.initial();
  }

  @override
  bool get isLoading => this._isLoading;

  @override
  bool get isLoaded => this._isLoaded;

  @override
  bool get isError => this._isError;

  @override
  String get errorMessage => this._errorMessage;

  @override
  List<T> get items => this.transforms(this._items);

  @override
  T? get data => this.transform(this._data);

  @override
  StreamController<bool> get isLoadingSC => this._isLoadingSC;

  @override
  StreamController<bool> get isLoadedSC => this._isLoadedSC;

  @override
  StreamController<bool> get isErrorSC => this._isErrorSC;

  @override
  StreamController<String> get errorMessageSC => this._errorMessageSC;

  @override
  StreamController<List<T>?> get itemsSC => this._itemsSC;

  @override
  StreamController<T?> get dataSC => this._dataSC;

  @override
  void toLoadingStatus() {
    this._isLoading = true;
    this._isLoadingSC.add(true);

    this._isLoaded = false;
    this._isLoadedSC.add(false);

    this._isError = false;
    this._isErrorSC.add(false);
  }

  @override
  void toLoadedStatus() {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isLoaded = true;
    this._isLoadedSC.add(true);
  }

  @override
  void toErrorStatus(e) {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isError = true;
    this._isErrorSC.add(true);

    this._errorMessage = e.toString();
    this._errorMessageSC.add(e.toString());

    print("error: ${e.toString()}");
  }

  @override
  List<T> transforms(tss) {
    return List<T>.empty(growable: true);
  }

  @override
  T? transform(ts) {
    return null;
  }

  @override
  Future<void> fetch({Map<String, dynamic>? params, bool isMock: false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = Map<String, dynamic>();
      }

      if (isMock) {
        await TimeHelper.sleep();
        data = {"items": this.options.getMockItems()};
      } else {
        Response response =
            await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this._items = data["items"];
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future<void> fetchAfterId(
      {Map<String, dynamic>? params, bool isMock = false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = Map<String, dynamic>();
      }

      if (isMock) {
        await TimeHelper.sleep();
        data = {"items": this.options.getMockItems()?.sublist(0, 6)};
      } else {
        Response response =
            await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this._items = [...(this._items ?? []), ...(data["items"])];
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future<void> get(String id,
      {Map<String, dynamic>? params, bool isMock: false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = Map<String, dynamic>();
      }

      if (isMock) {
        await TimeHelper.sleep();
        Map<String, dynamic> mock = this
            .options
            .getMockItems()!
            .firstWhere((element) => id == element["product_id"]);
        data = {"data": mock};
      } else {
        Response response =
            await Requester.get(this.options.getBaseUrl(), params);
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = js;
      }

      this._data = data["data"];
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  void forceValueNotify() {
    this._isLoadingSC.add(true);
    this._isLoadedSC.add(false);
    this._isErrorSC.add(false);
    this._errorMessageSC.add("");

    this._itemsSC.add(null);
    this._dataSC.add(null);

    this._isLoadingSC.add(this.isLoading);
    this._isLoadedSC.add(this.isLoaded);
    this._isErrorSC.add(this.isError);
    this._errorMessageSC.add(this.errorMessage);

    this._itemsSC.add(this.items);
    this._dataSC.add(this.data);
  }

  @override
  void initial() {
    this._isLoadingSC = BehaviorSubject<bool>();
    this._isLoadedSC = BehaviorSubject<bool>();
    this._isErrorSC = BehaviorSubject<bool>();
    this._errorMessageSC = BehaviorSubject<String>();

    this._itemsSC = BehaviorSubject<List<T>?>();
    this._dataSC = BehaviorSubject<T?>();
  }

  @override
  void dispose() {
    this._isLoadingSC.close();
    this._isLoadedSC.close();
    this._isErrorSC.close();
    this._errorMessageSC.close();
  }

  @override
  void alertError(dynamic e) {
    String title = "Error";
    dynamic message = e;

    if (e is Map && message is Map) {
      title = e["code"] ?? "Error";
      message = e["message"] ?? e;
    }

    Flushbar(
      title: title,
      message: message.toString(),
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(this.buildCtx);
  }
}

class BaseUIRepository implements IBaseUIRepository {
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;
  String _errorMessage = "";

  late StreamController<bool> _isLoadingSC;
  late StreamController<bool> _isLoadedSC;
  late StreamController<bool> _isErrorSC;
  late StreamController<String> _errorMessageSC;

  BaseUIRepository() {
    this._isLoadingSC = StreamController<bool>();
    this._isLoadedSC = StreamController<bool>();
    this._isErrorSC = StreamController<bool>();
    this._errorMessageSC = StreamController<String>();
  }

  @override
  bool get isLoading => this._isLoading;

  @override
  bool get isLoaded => this._isLoaded;

  @override
  bool get isError => this._isError;

  @override
  String get errorMessage => this._errorMessage;

  @override
  StreamController<bool> get isLoadingSC => this._isLoadingSC;

  @override
  StreamController<bool> get isLoadedSC => this._isLoadedSC;

  @override
  StreamController<bool> get isErrorSC => this._isErrorSC;

  @override
  StreamController<String> get errorMessageSC => this._errorMessageSC;

  @override
  void toLoadingStatus() {
    this._isLoading = true;
    this._isLoadingSC.add(true);

    this._isLoaded = false;
    this._isLoadedSC.add(false);

    this._isError = false;
    this._isErrorSC.add(false);
  }

  @override
  void toLoadedStatus() {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isLoaded = true;
    this._isLoadedSC.add(true);
  }

  @override
  void toErrorStatus(e) {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isError = true;
    this._isErrorSC.add(true);

    this._errorMessage = e.toString();
    this._errorMessageSC.add(e.toString());

    print("error: ${e.toString()}");
  }

  @override
  void dispose() {
    this._isLoadingSC.close();
    this._isLoadedSC.close();
    this._isErrorSC.close();
    this._errorMessageSC.close();
  }
}

class NewRepository implements IRepositories {
  final BuildContext buildCtx;
  final IConfig config;
  ProductRepository? _productRepository;
  BannerRepository? _bannerRepository;
  CategoryRepository? _categoryRepository;
  CartRepository? _cartRepository;
  NotificationRepository? _notificationRepository;

  NewRepository({
    required this.buildCtx,
    required this.config,
  });

  @override
  ProductRepository productRepository() {
    if (this._productRepository == null) {
      this._productRepository = ProductRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        options: NewRepositoryOptions(
          baseUrl: "${config.baseAPI()}/products",
          mockItems: mockProducts,
          mockItem: mockProductDetail,
        ),
      );
    }
    return this._productRepository!;
  }

  @override
  BannerRepository bannerRepository() {
    if (this._bannerRepository == null) {
      this._bannerRepository = BannerRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        options: NewRepositoryOptions(
          baseUrl: "${config.baseAPI()}/banners",
          mockItems: mockBanners,
        ),
      );
    }
    return this._bannerRepository!;
  }

  @override
  CategoryRepository categoryRepository() {
    if (this._categoryRepository == null) {
      this._categoryRepository = CategoryRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        options: NewRepositoryOptions(
          baseUrl: "${config.baseAPI()}/categories",
          mockItems: mockCategories,
        ),
      );
    }
    return this._categoryRepository!;
  }

  @override
  CartRepository cartRepository() {
    if (this._cartRepository == null) {
      this._cartRepository = CartRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        options: NewRepositoryOptions(
          baseUrl: "${config.baseAPI()}/cart",
          mockItem: mockCart,
        ),
      );
    }
    return this._cartRepository!;
  }

  @override
  NotificationRepository notificationRepository() {
    if (this._notificationRepository == null) {
      this._notificationRepository = NotificationRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        options: NewRepositoryOptions(
          baseUrl: "${config.baseAPI()}/notifications",
          mockItems: mockNotifications,
        ),
      );
    }
    return this._notificationRepository!;
  }
}

class NewRepositoryOptions implements IRepositoryOptions {
  final String baseUrl;
  final String? findUrl;
  final String? addUrl;
  final String? updateUrl;
  final String? deleteUrl;
  final List<Map<String, dynamic>>? mockItems;
  final Map<String, dynamic>? mockItem;

  NewRepositoryOptions({
    required this.baseUrl,
    this.findUrl,
    this.addUrl,
    this.updateUrl,
    this.deleteUrl,
    this.mockItems,
    this.mockItem,
  });

  @override
  String getBaseUrl() {
    return this.baseUrl;
  }

  @override
  String? getFindUrl() {
    return this.findUrl;
  }

  @override
  String? getAddUrl() {
    return this.addUrl;
  }

  @override
  String? getUpdateUrl() {
    return this.updateUrl;
  }

  @override
  String? getDeleteUrl() {
    return this.deleteUrl;
  }

  @override
  List<Map<String, dynamic>>? getMockItems() {
    return this.mockItems;
  }

  @override
  Map<String, dynamic>? getMockItem() {
    return this.mockItem;
  }
}
