// ignore_for_file: close_sinks

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/mocks/banners/banners.dart';
import 'package:singh_architecture/mocks/carts/carts.dart';
import 'package:singh_architecture/mocks/categories/categories.dart';
import 'package:singh_architecture/mocks/products/product_detail.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/models/cart_model.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/repositories/cart_repository.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class BaseDataRepository<T> implements IBaseDataRepository {
  final IConfig config;
  final IRepositoryOptions options;

  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;
  String _errorMessage = "";
  List<T>? items;
  T? data;

  late StreamController<bool> _isLoadingSC;
  late StreamController<bool> _isLoadedSC;
  late StreamController<bool> _isErrorSC;
  late StreamController<String> _errorMessageSC;
  late StreamController<List<T>?> _itemsSC;
  late StreamController<T?> _dataSC;

  BaseDataRepository(
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
  Future<void> fetch({Map<String, dynamic>? params, bool isMock: false}) async {
    this.toLoadingStatus();
    TimeHelper.sleep();
    this.toLoadedStatus();
  }

  @override
  Future<void> get(String id,
      {Map<String, dynamic>? params, bool isMock: false}) async {
    this.toLoadingStatus();
    TimeHelper.sleep();
    this.toLoadedStatus();
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
  final IConfig config;
  ProductRepository? _productRepository;
  BannerRepository? _bannerRepository;
  CategoryRepository? _categoryRepository;
  CartRepository? _cartRepository;

  NewRepository({
    required this.config,
  });

  @override
  ProductRepository productRepository() {
    if (this._productRepository == null) {
      this._productRepository = ProductRepository(
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
        config: this.config,
        options: NewRepositoryOptions(
          baseUrl: "${config.baseAPI()}/cart",
          mockItem: mockCart,
        ),
      );
    }
    return this._cartRepository!;
  }
}

class NewRepositoryOptions implements IRepositoryOptions {
  final String baseUrl;
  final String? addUrl;
  final String? updateUrl;
  final String? deleteUrl;
  final List<Map<String, dynamic>>? mockItems;
  final Map<String, dynamic>? mockItem;

  NewRepositoryOptions({
    required this.baseUrl,
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
