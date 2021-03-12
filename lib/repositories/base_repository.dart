import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

abstract class IBaseRepository {
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

class BaseRepository implements IBaseRepository {
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;
  String _errorMessage = "";

  StreamController<bool> _isLoadingSC = StreamController<bool>();
  StreamController<bool> _isLoadedSC = StreamController<bool>();
  StreamController<bool> _isErrorSC = StreamController<bool>();
  StreamController<String> _errorMessageSC = StreamController<String>();

  @override
  bool get isLoading => this._isLoading;

  @override
  bool get isLoaded => this._isLoaded;

  @override
  bool get isError => this._isError;

  @override
  String get errorMessage => _errorMessage;

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
  productRepository(IConfig config) {
    return ProductRepository(config: config);
  }
}
