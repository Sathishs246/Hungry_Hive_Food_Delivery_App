import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/services/notification_service.dart';
import 'package:hungry_hive_food_app/view/main_tabview/main_tabview.dart';
import 'package:hungry_hive_food_app/view/on_boarding/startup_view.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controller/cart_controller.dart';
import 'controller/favorite_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  NotificationService.initializeNotification();
  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseMessagingBackgroundHandler,
  );
  Get.put(CartController());
  Get.put(FavoriteController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hungry Hive Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Metropolis",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const StartupView(),
    );
  }
}
