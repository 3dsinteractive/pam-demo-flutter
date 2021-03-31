import 'dart:async';

import 'package:flutter_apns/apns.dart';
import 'package:flutter_apns/flutter_apns.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:pam_flutter/pam_notification.dart';
import 'package:pam_flutter/types.dart';

class AppNotificationService {
  AppNotificationService._();

  static late PushConnector _connector;
  static bool? isAppClearIntent;

  static Future<void> initial() async {
    if (isAppClearIntent == null) {
      isAppClearIntent = true;
    }

    _connector = createPushConnector();
    _connector.configure(
      onLaunch: AppNotificationHandler._onLaunch,
      onResume: AppNotificationHandler._onResume,
      onMessage: AppNotificationHandler._onMessage,
    );
  }

  static Future<void> askNotificationPermission() async {
    _connector.requestNotificationPermissions();
    print("_connector = ${_connector.token.value}");
    if (_connector.token.value != null) {
      Pam.trackSavePush(token: _connector.token.value!);
    }
  }

  static void clearIntent() {
    isAppClearIntent = false;
  }
}

class AppNotificationHandler {
  AppNotificationHandler._();

  static Future<void> _onLaunch(RemoteMessage rm) async {
    if (!(await PamNotification.isPamMessageReceived(PamStandardCallback.on_launch, rm.data))) {
      // handler your own notification
    }
  }

  static Future<void> _onResume(RemoteMessage rm) async {
    if (!(await PamNotification.isPamMessageReceived(PamStandardCallback.on_resume, rm.data))) {
      // handler your own notification
    }
  }

  static Future<void> _onMessage(RemoteMessage rm) async {
    if (!(await PamNotification.isPamMessageReceived(PamStandardCallback.on_message, rm.data))) {
      // handler your own notification
    }
  }
}
