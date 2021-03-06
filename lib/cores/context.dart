import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/shared_preferences.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/locale_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

abstract class IContext {
  Future<void> initial();

  IRepositories repositories();

  LocaleRepository localeRepository();

  ISharedPreferences sharedPreferences();
}

class Context implements IContext {
  final BuildContext buildCtx;
  final IConfig config;
  IRepositories? _repositories;
  LocaleRepository? _localeRepository;
  late ISharedPreferences _sharedPreferences;

  Context({
    required this.buildCtx,
    required this.config,
  });

  @override
  Future<void> initial() async {
    this._sharedPreferences = SharedPreferences();
    await this._sharedPreferences.initial();
  }

  @override
  IRepositories repositories() {
    if (this._repositories == null) {
      this._repositories = NewRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences(),
      );
    }
    return this._repositories!;
  }

  @override
  LocaleRepository localeRepository() {
    if (this._localeRepository == null) {
      this._localeRepository = LocaleRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences(),
        options: NewRepositoryOptions(
          baseUrl: "",
        ),
      );
    }
    return this._localeRepository!;
  }

  @override
  ISharedPreferences sharedPreferences() {
    return this._sharedPreferences;
  }
}
