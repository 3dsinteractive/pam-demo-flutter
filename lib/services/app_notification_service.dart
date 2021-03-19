import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:singh_architecture/pams/pam_notification.dart';

class AppNotificationService {
  AppNotificationService._();

  static Future<void> initial() async {
    FirebaseMessaging.onMessage
        .listen(AppNotificationHandler.onForegroundMessageHandler);
    FirebaseMessaging.onBackgroundMessage(
        AppNotificationHandler.onBackgroundMessageHandler);
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
    String? token = await FirebaseMessaging.instance.getToken();

    Pam.setDeviceToken(token ?? "");
    return token;
  }
}

class AppNotificationHandler {
  AppNotificationHandler._();

  static Future<void> initial() async {}

  static List<void Function(Map<String, dynamic>)>
      _onBackgroundMessageHandlers = List.empty(growable: true);
  static List<void Function(Map<String, dynamic>)>
      _onForegroundMessageHandlers = List.empty(growable: true);

  static void addOnBackgroundMessageHandler(Function(Map<String, dynamic>) cb) {
    _onBackgroundMessageHandlers.add(cb);
  }

  static void addOnForegroundMessageHandler(Function(Map<String, dynamic>) cb) {
    _onForegroundMessageHandlers.add(cb);
  }

  static Future<void> onBackgroundMessageHandler(RemoteMessage rm) async {
    if (!PamNotification.isPamMessageReceived(rm)) {
      // application message handler
      _onBackgroundMessageHandlers.forEach((cb) {
        cb.call(rm.data);
      });
    }
  }

  static Future<void> onForegroundMessageHandler(RemoteMessage rm) async {
    if (!PamNotification.isPamMessageReceived(rm)) {
      // application message handler
      _onForegroundMessageHandlers.forEach((cb) {
        cb.call(rm.data);
      });
    }
  }
}
