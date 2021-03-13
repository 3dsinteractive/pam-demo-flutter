import 'dart:async';

import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

abstract class IRepositories {
  ProductRepository productRepository(IConfig config);
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

  void fetch({
    Map<String, dynamic>? params,
    bool isMock: false,
  });

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