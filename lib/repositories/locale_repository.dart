import 'dart:convert';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/constants.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocaleRepository extends BaseDataRepository {
  final IConfig config;
  final IRepositoryOptions options;
  late Map<String, dynamic> _words;

  LocaleRepository({
    required this.config,
    required this.options,
  }) : super(config, options);

  Future<void> loadLocale({LANGUAGE? lang}) async {
    late String langStr;

    if (lang == LANGUAGE.TH) {
      langStr = "th";
    } else if (lang == LANGUAGE.EN) {
      langStr = "en";
    } else {
      langStr = this.config.defaultLanguage()!;
    }

    this.toLoadingStatus();

    try {
      String rawJson = await rootBundle.loadString(
          "lib/locales/$langStr.json");
      this._words = json.decode(rawJson);

      this.toLoadedStatus();
    } catch (e) {
      this.toErrorStatus(e);
      throw (e);
    }
  }

  String getString(String key) {
    return this._words[key] ?? "";
  }
}
