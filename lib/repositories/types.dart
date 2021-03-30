import 'dart:async';

import 'package:singh_architecture/repositories/authentication_repository.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/repositories/cart_repository.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/repositories/notification_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

abstract class IRepositories {
  AuthenticationRepository authenticationRepository();

  ProductRepository productRepository();

  BannerRepository bannerRepository();

  CategoryRepository categoryRepository();

  CartRepository cartRepository();

  NotificationRepository notificationRepository();
}

abstract class IRepositoryOptions {
  String getBaseUrl();

  String? getFindUrl();

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

  List<T> get items;

  T? get data;

  StreamController<bool> get isLoadingSC;

  StreamController<bool> get isLoadedSC;

  StreamController<bool> get isErrorSC;

  StreamController<String> get errorMessageSC;

  StreamController<List<T>?> get itemsSC;

  StreamController<T?> get dataSC;

  void toLoadingStatus();

  void toLoadedStatus();

  void toErrorStatus(dynamic e);

  List<T> transforms(dynamic tss);

  T? transform(dynamic ts);

  Future<void> fetch({
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> fetchAfterId({
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> get(
    String id, {
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> add({
    required Map<String, dynamic> payload,
    bool isMock: false,
  });

  void forceValueNotify();

  void initial();

  void dispose();

  void alertError(dynamic e);
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
