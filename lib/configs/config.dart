import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

abstract class IConfig {
  Future<void> initial();

  String? appName();

  String? defaultLanguage();

  String? baseAPI();
}

class Config implements IConfig {
  Map<String, dynamic>? env;
  String? _appName;
  String? _defaultLanguage;
  String? _baseAPI;

  Future<void> initial() async {
    try {
      String rawJson = await rootBundle.loadString("lib/env.json");
      this.env = json.decode(rawJson);
    } catch (e) {
      throw (e);
    }
  }

  @override
  String? appName() {
    if (this._appName == null) {
      this._appName = env?["app_name"];
    }
    return this._appName;
  }

  @override
  String? defaultLanguage() {
    if (this._defaultLanguage == null) {
      this._defaultLanguage = env?["default_language"];
    }
    return this._defaultLanguage;
  }

  @override
  String? baseAPI() {
    if (this._baseAPI == null) {
      this._baseAPI = env?["base_api"];
    }
    return this._baseAPI;
  }
}
