import 'dart:async';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/mocks/banners/banners.dart';
import 'package:singh_architecture/mocks/categories/categories.dart';
import 'package:singh_architecture/mocks/products/product_detail.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/repositories/locale_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

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
    this._isLoadingSC = StreamController<bool>();
    this._isLoadedSC = StreamController<bool>();
    this._isErrorSC = StreamController<bool>();
    this._errorMessageSC = StreamController<String>();
    this._itemsSC = StreamController<List<T>?>();
    this._dataSC = StreamController<T?>();
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
  Future<void> fetch(
      {Map<String, dynamic>? params, bool isMock: false}) async {}

  @override
  Future<void> get(String id,
      {Map<String, dynamic>? params, bool isMock: false}) async {}

  @override
  void dispose() {
    this._isLoadingSC.close();
    this._isLoadedSC.close();
    this._isErrorSC.close();
    this._errorMessageSC.close();
    this._itemsSC.close();
    this._dataSC.close();
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

  NewRepository({
    required this.config,
  });

  @override
  productRepository() {
    return ProductRepository(
      config: this.config,
      options: NewRepositoryOptions(
        baseUrl: "${config.baseAPI()}/products",
        mockItems: mockProducts,
        mockItem: mockProductDetail,
      ),
    );
  }

  @override
  BannerRepository bannerRepository() {
    return BannerRepository(
      config: this.config,
      options: NewRepositoryOptions(
        baseUrl: "${config.baseAPI()}/banners",
        mockItems: mockBanners,
      ),
    );
  }

  @override
  CategoryRepository categoryRepository() {
    return CategoryRepository(
      config: this.config,
      options: NewRepositoryOptions(
        baseUrl: "${config.baseAPI()}/categories",
        mockItems: mockCategories,
      ),
    );
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
