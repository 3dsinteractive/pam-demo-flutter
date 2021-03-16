import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:singh_architecture/pams/pam_queue_manager.dart';
import 'package:singh_architecture/pams/types.dart';
import 'package:singh_architecture/utils/requester.dart';
import 'dart:io' show Platform;
import 'package:uuid/uuid.dart';

class Pam {
  Pam._();

  static bool _isAppReady = false;
  static late Map<String, dynamic> _config;
  static late SharedPreferences _sharedPreferences;
  static String? _pamServer;
  static String? _publicDBAlias;
  static String? _loginDBAlias;
  static late bool _enableLog;
  static late PamQueueManager _pamQueueManager;
  static List<void Function(Map<String, dynamic>)> onTokenListener =
      List<void Function(Map<String, dynamic>)>.empty(growable: true);
  static List<void Function(Map<String, dynamic>)> onMessageListener =
      List<void Function(Map<String, dynamic>)>.empty(growable: true);
  static List<Map<String, dynamic>> _pendingMessage =
      List<Map<String, dynamic>>.empty(growable: true);
  static late String _platformVersion;
  static late String _osVersion;
  static late String _appVersion;
  static String? _contactId;
  static String? _customerId;

  static Future<void> initial({bool enableLog = false}) async {
    _isAppReady = false;
    _enableLog = enableLog;
    _pamQueueManager = PamQueueManager(callback: postTracker);
    await initialConfig();
    await initialSharedPreferences();
    await initialAppInfo();
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

  static Future<void> initialAppInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = "${packageInfo.packageName} (${packageInfo.version})";

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _osVersion = "Android: ${androidInfo.version.sdkInt}";
      _platformVersion =
          "Android: ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt}), ${androidInfo.manufacturer} ${androidInfo.model}";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _osVersion = "${iosInfo.systemName}: ${iosInfo.systemVersion}";
      _platformVersion =
          "${iosInfo.systemName}: ${iosInfo.systemVersion}, ${iosInfo.name} ${iosInfo.model}";
    }
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

  static void listen(
      String eventName, void Function(Map<String, dynamic>) callback) {
    if (eventName.toLowerCase() == PamStandardCallback.on_token) {
      onTokenListener.add(callback);
    } else if (eventName.toLowerCase() == PamStandardCallback.on_message) {
      onMessageListener.add(callback);
    }
  }

  static void dispatch(String eventName, Map<String, dynamic> payload) {
    if (eventName.toLowerCase() == PamStandardCallback.on_token) {
      onTokenListener.forEach((cb) {
        cb.call(payload);
      });
    } else if (eventName.toLowerCase() == PamStandardCallback.on_message) {
      onMessageListener.forEach((cb) {
        cb.call(payload);
      });
    }
  }

  static void askNotificationPermission() {
    saveStringToSharedPref(PamStandardSharePreferenceKey.push_key, "token");
  }

  static void appReady() {
    if (!_isAppReady) {
      _isAppReady = true;
      track(PamStandardEvent.app_launch);
      _pendingMessage.forEach((payload) {
        dispatch(PamStandardCallback.on_message, payload);
      });
      _pendingMessage.clear();
    }
  }

  static dynamic getFromSharedPref(String key) {
    return _sharedPreferences.get(key);
  }

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

  static Future<bool> removeFromSharedPref(String key) {
    return _sharedPreferences.remove(key);
  }

  static Future<String> getSessionId() async {
    int? expire = getIntFromSharedPref("session_expire_in_mils");
    String? session = getStringFromSharedPref("session_id");

    if ((expire == null || session == null) ||
        (DateTime.now().millisecondsSinceEpoch - expire > (1000 * 60 * 60))) {
      int newExpire = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
      session = Uuid().v4();

      await saveIntToSharedPref("session_expire_in_mils", newExpire);
      await saveStringToSharedPref("session_id", session);
    } else {
      int newExpire = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;

      await saveIntToSharedPref("session_expire_in_mils", newExpire);
      await saveStringToSharedPref("session_id", session);
    }

    return session;
  }

  static String? getContactId() {
    if (_contactId == null) {
      _contactId =
          getStringFromSharedPref(PamStandardSharePreferenceKey.contact_id);
    }
    return _contactId!;
  }

  static String? getCustomerId() {
    if (_customerId == null) {
      _customerId =
          getStringFromSharedPref(PamStandardSharePreferenceKey.customer_id);
    }
    return _customerId!;
  }

  static Future<void> userLogin(String customerId) async {
    await saveStringToSharedPref(PamStandardSharePreferenceKey.customer_id, customerId);
    track(
      PamStandardEvent.login,
      payload: {"customer": customerId},
    );
  }

  static Future<void> userLogout() async {
    Map<String, dynamic> payload = {};
    if (Platform.isAndroid) {
      payload["_delete_media"] = {"android_notification": ""};
    } else if (Platform.isIOS) {
      payload["_delete_media"] = {"ios_notification": ""};
    }

    track(
      PamStandardEvent.logout,
      payload: payload,
    );
    await removeFromSharedPref(PamStandardSharePreferenceKey.customer_id);
    await removeFromSharedPref(PamStandardSharePreferenceKey.contact_id);
  }

  static Future<void> setDeviceToken(String token) async {
    Map<String, dynamic> payload = {};
    if (Platform.isAndroid) {
      payload["android_notification"] = token;
    } else if (Platform.isIOS) {
      payload["ios_notification"] = token;
    }

    track(
      PamStandardEvent.save_push,
      payload: payload,
    );
    dispatch(PamStandardCallback.on_token, {
      "token": token,
    });
  }

  static void track(
    String eventName, {
    Map<String, dynamic>? payload,
    bool deleteLoginContactAfterPost = false,
  }) {
    return _pamQueueManager.enqueue(eventName,
        payload: payload,
        deleteLoginContactAfterPost: deleteLoginContactAfterPost);
  }

  static bool isUserLogin() {
    if (_contactId == null) {
      _contactId =
          getStringFromSharedPref(PamStandardSharePreferenceKey.customer_id);
      return _contactId != null;
    }
    return true;
  }

  static Future<void> postTracker(
    String eventName,
    Map<String, dynamic> payload, {
    bool deleteLoginContactAfterPost = false,
  }) async {
    String url = "${pamServer()}/trackers/events";
    Map<String, dynamic> body = {
      "event": eventName,
      "platform": _platformVersion,
    };
    Map<String, dynamic> formField = {
      "os_version": _osVersion,
      "app_version": _appVersion,
      "_session_id": await getSessionId(),
    };

    if (getStringFromSharedPref(
            PamStandardSharePreferenceKey.login_contact_id) !=
        null) {
      formField["_contact_id"] = getStringFromSharedPref(
          PamStandardSharePreferenceKey.login_contact_id);
    } else if (getStringFromSharedPref(
            PamStandardSharePreferenceKey.contact_id) !=
        null) {
      formField["_contact_id"] =
          getStringFromSharedPref(PamStandardSharePreferenceKey.contact_id);
    }

    payload.forEach((key, value) {
      if (key != "page_url" || key != "page_title") {
        formField[key] = value;
      } else {
        body[key] = value;
      }
    });

    if (isUserLogin()) {
      formField["_database"] = loginDBAlias();
      formField["customer"] = getCustomerId();
    } else {
      formField["_database"] = publicDBAlias();
    }

    body["form_fields"] = formField;

    if (_enableLog) {
      print("🦄 : POST Event = 🍀$eventName🍀");
      print("🦄 : Payload");
      print(
          "🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉\n$body\n🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉🍉\n\n");
    }

    Response response = await Requester.post(url, body);
    if (_enableLog) {
      print("Track response is ${response.body}\n");
    }

    if (response.statusCode == 200) {
      IPamResponse pamResponse =
          IPamResponse.fromJson(json.decode(response.body));
      if (pamResponse.ContactId != null) {
        if (isUserLogin()) {
          saveStringToSharedPref(PamStandardSharePreferenceKey.login_contact_id,
              pamResponse.ContactId!);
        } else {
          saveStringToSharedPref(
              PamStandardSharePreferenceKey.contact_id, pamResponse.ContactId!);
        }
      }
    } else {
      if (_enableLog) {
        print("Track error ${response.body}\n");
      }
    }

    if (deleteLoginContactAfterPost) {
      _customerId = null;
      removeFromSharedPref(PamStandardSharePreferenceKey.customer_id);
      removeFromSharedPref(PamStandardSharePreferenceKey.login_contact_id);
    }
    _pamQueueManager.nextQueue();

    if (_enableLog) {
      print("Track has been send\n");
    }
  }
}
