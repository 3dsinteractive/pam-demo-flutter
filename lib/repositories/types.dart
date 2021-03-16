import 'dart:async';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/repositories/cart_repository.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

abstract class IRepositories {
  ProductRepository productRepository();

  BannerRepository bannerRepository();

  CategoryRepository categoryRepository();

  CartRepository cartRepository();
}

abstract class IRepositoryOptions {
  String getBaseUrl();

  String? getAddUrl();

  String? getUpdateUrl();

  String? getDeleteUrl();

  List<Map<String, dynamic>>? getMockItems();

  Map<String, dynamic>? getMockItem();
}

abstract class IBaseDataRepository<T> {
  bool get isLoading;

  bool get isLoaded;

  bool get isError;

  String get errorMessage;

  StreamController<bool> get isLoadingSC;

  StreamController<bool> get isLoadedSC;

  StreamController<bool> get isErrorSC;

  StreamController<String> get errorMessageSC;

  StreamController<List<T>?> get itemsSC;

  StreamController<T?> get dataSC;

  void toLoadingStatus();

  void toLoadedStatus();

  void toErrorStatus(dynamic e);

  Future<void> fetch({
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> fetchAfterId(
    String afterId, {
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> get(
    String id, {
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  void forceValueNotify();

  void initial();

  void dispose();
}

abstract class IBaseUIRepository<T> {
  bool get isLoading;

  bool get isLoaded;

  bool get isError;

  String get errorMessage;

  StreamController<bool> get isLoadingSC;

  StreamController<bool> get isLoadedSC;

  StreamController<bool> get isErrorSC;

  StreamController<String> get errorMessageSC;

  void toLoadingStatus();

  void toLoadedStatus();

  void toErrorStatus(dynamic e);

  void dispose();
}
