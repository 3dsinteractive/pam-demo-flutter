import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pam_flutter/pam_notification.dart';

class AppNotificationService {
  AppNotificationService._();

  static Future<void> initial() async {
    await Firebase.initializeApp();

    FirebaseMessaging.onMessage
        .listen(AppNotificationHandler._onForegroundMessageHandler);
    FirebaseMessaging.onMessageOpenedApp
        .listen(AppNotificationHandler._onOpenedMessageHandler);
    FirebaseMessaging.onBackgroundMessage(
        AppNotificationHandler._onBackgroundMessageHandler);
  }

  static Future<String?> askNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    return await FirebaseMessaging.instance.getToken();
  }
}

class AppNotificationHandler {
  AppNotificationHandler._();

  static List<void Function(Map<String, dynamic>)>
      _onBackgroundMessageHandlers = List.empty(growable: true);
  static List<void Function(Map<String, dynamic>)> _onOpenedMessageHandlers =
      List.empty(growable: true);
  static List<void Function(Map<String, dynamic>)>
      _onForegroundMessageHandlers = List.empty(growable: true);

  static void addOnBackgroundMessageHandler(Function(Map<String, dynamic>) cb) {
    _onBackgroundMessageHandlers.add(cb);
  }

  static void addOnForegroundMessageHandler(Function(Map<String, dynamic>) cb) {
    _onForegroundMessageHandlers.add(cb);
  }

  static Future<void> _onBackgroundMessageHandler(RemoteMessage rm) async {
    if (!await PamNotification.isPamMessageReceived(rm.data)) {
      // application message handler
      _onBackgroundMessageHandlers.forEach((cb) {
        cb.call(rm.data);
      });
    }
  }

  static Future<void> _onOpenedMessageHandler(RemoteMessage rm) async {
    if (!await PamNotification.isPamMessageOpenedReceived(rm.data)) {
      // application message handler
      _onOpenedMessageHandlers.forEach((cb) {
        cb.call(rm.data);
      });
    }
  }

  static Future<void> _onForegroundMessageHandler(RemoteMessage rm) async {
    if (!await PamNotification.isPamMessageReceived(rm.data)) {
      // application message handler
      _onForegroundMessageHandlers.forEach((cb) {
        cb.call(rm.data);
      });
    }
  }
}
