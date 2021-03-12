import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:singh_architecture/cores/constants.dart';

abstract class IConfig {
  Future<void> initial();

  String? appName();

  LANGUAGE? defaultLanguage();

  String? baseAPI();
}

class Config implements IConfig {
  Map<String, dynamic>? env;
  String? _appName;
  LANGUAGE? _defaultLanguage;
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
  LANGUAGE? defaultLanguage() {
    if (this._defaultLanguage == null) {
      String? lang = env?["default_language"];
      if (lang == "en") {
        this._defaultLanguage = LANGUAGE.EN;
      } else {
        this._defaultLanguage = LANGUAGE.TH;
      }
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
