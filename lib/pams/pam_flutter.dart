import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:singh_architecture/pams/types.dart';
import 'dart:io' show Platform;

import 'package:uuid/uuid.dart';

class PamSDK {
  PamSDK._();

  static bool _isAppReady = false;
  static late Map<String, dynamic> _config;
  static late SharedPreferences _sharedPreferences;
  static String? _pamServer;
  static String? _publicDBAlias;
  static String? _loginDBAlias;
  static late bool _enableLog;

  static Future<void> initial({bool enableLog = false}) async {
    _isAppReady = false;
    _enableLog = enableLog;
    await initialConfig();
    await initialSharedPreferences();
    _isAppReady = true;
  }

  static Future<void> initialConfig() async {
    try {
      String raw = await rootBundle.loadString("lib/pam-config.json");
      _config = json.decode(raw);
    } catch (e) {
      throw (e);
    }
  }

  static Future<void> initialSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String pamServer() {
    if (_pamServer == null) {
      _pamServer = _config["pam-server"];
    }
    return _pamServer!;
  }

  static String publicDBAlias() {
    if (_publicDBAlias == null) {
      _publicDBAlias = _config["public-db-alias"];
    }
    return _publicDBAlias!;
  }

  static String loginDBAlias() {
    if (_publicDBAlias == null) {
      _publicDBAlias = _config["public-db-alias"];
    }
    return _publicDBAlias!;
  }

  static void dispatch(String eventName, Map<String, dynamic> payload) {}

  static void appReady() {}

  static dynamic getFromSharedPref(String key) {}

  static String? getStringFromSharedPref(String key) {
    return _sharedPreferences.getString(key);
  }

  static int? getIntFromSharedPref(String key) {
    return _sharedPreferences.getInt(key);
  }

  static Future<bool> saveStringToSharedPref(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  static Future<bool> saveIntToSharedPref(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  static Future<bool> removeToSharedPref(String key) {
    return _sharedPreferences.remove(key);
  }

  static Future<String> getSessionId() async {
    int? expire = getIntFromSharedPref("session_expire_in_mils");
    String? session = getStringFromSharedPref("session_id");

    if ((expire == null || session == null) || (DateTime.now().millisecondsSinceEpoch - expire > (1000 * 60 * 60))) {
      int newExpire = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
      session = Uuid().v4();

      await saveIntToSharedPref("session_expire_in_mils", newExpire);
      await saveStringToSharedPref("session_id", session);
    }else{
      int newExpire = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;

      await saveIntToSharedPref("session_expire_in_mils", newExpire);
      await saveStringToSharedPref("session_id", session);
    }

    return session;
  }

  static String? getContactId() {
    return getStringFromSharedPref("_contact_id");
  }

  static String? getCustomerId() {
    return getStringFromSharedPref("customer_id");
  }

  static Future<void> userLogin(String customerId) async {
    await saveStringToSharedPref("customer_id", customerId);
    await track(PamStandardEvent.login, {"customer": customerId});
  }

  static Future<void> userLogout() async {
    Map<String, dynamic> payload = {};
    if (Platform.isAndroid) {
      payload["_delete_media"] = {"android_notification": ""};
    } else if (Platform.isIOS) {
      payload["_delete_media"] = {"ios_notification": ""};
    }

    await track(PamStandardEvent.logout, payload);
    await removeToSharedPref("customer_id");
    await removeToSharedPref("login_contact_id");
  }

  static Future<void> savePushKey(String token) {
    Map<String, dynamic> payload = {};
    if (Platform.isAndroid) {
      payload["android_notification"] = token;
    } else if (Platform.isIOS) {
      payload["ios_notification"] = token;
    }

    return track(PamStandardEvent.save_push, payload);
  }

  static Future<void> track(
      String eventName, Map<String, dynamic> payload) async {}
}
