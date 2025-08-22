import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  ///Handles message when the app is in the background or terminated
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    ///Initialize local notification plugin and show notification
    await _initializLocalNotification();
    await _showFlutterNotification(message);
  }

  static Future<void> initializeNotification() async {
    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App Opend :${message.data}');
    });

    await _getFcmToken();
    await _initializLocalNotification();
    await _getInitialNotification();
  }

  static Future<void> _getFcmToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');
    } catch (e) {
      print('Error fetching FCM token: $e');
      // You could show a snackbar or retry here
    }
  }

  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    Map<String, dynamic>? data = message.data;
    String title = notification?.title ?? data['title'] ?? 'No Title';
    String body = notification?.body ?? data['body'] ?? 'No Body';

    //Android notification Config
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: 'Notification channel for test',
      priority: Priority.high,
      importance: Importance.high,
    );
    //Ios notification Config
    DarwinNotificationDetails iOSDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    //Combine platform-specfic settings
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    //show notification
    await flutterLocalNotificationsPlugin.show(
      0, //Notification ID
      title,
      body,
      notificationDetails,
    );
  }

  ///Initialize the local notification system(both Android and ios)
  static Future<void> _initializLocalNotification() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@drawable/ic_launcher');
    final DarwinInitializationSettings iOSInit = DarwinInitializationSettings();
    final InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iOSInit,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("user Tapped notification :${response.payload}");
      },
    );
  }

  static Future<void> _getInitialNotification() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      print('App launch :${message.data}');
    }
  }
}
