import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'channelId',
    'channelName',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  ); // kênh thông báo cho android

  Future<void> init() async {
    await _initLocalNotification();
    await _requestPermissionAndListen();
  }

  Future<void> _initLocalNotification() async {
    const androidInit = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); //icon default cho notification
    const initSettings = InitializationSettings(
        android: androidInit); //cài đặt khởi tạo cho local notification
    await _localNotifications
        .initialize(initSettings); //khởi tạo local notification

    // Tạo channel cho Android
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel); //tạo kênh thông báo cho android
  }

  Future<void> _requestPermissionAndListen() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    ); //

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        if (notification != null) {
          _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channel.id,
                _channel.name,
                channelDescription: _channel.description,
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        }
      });

      // Click khi app ở background hoặc bị kill
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('🟢 User clicked notification: ${message.data}');
      });
    } else {
      print('❌ Notification permission denied');
    }
  }
}
