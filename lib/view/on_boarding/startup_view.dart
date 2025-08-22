import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/color_extension.dart';
import '../home/home_view.dart';
import '../login/welcome_view.dart';
import '../main_tabview/main_tabview.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    goWelcome();
  }

  void goWelcome() async {
    await Future.delayed(const Duration(seconds: 5)); // splash delay
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAll(() => MainTabview());
    } else {
      Get.offAll(() => WelcomeView());
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/splash_bg.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/hungryhive_logo.png",
            width: media.width * 0.52,
            height: media.height * 0.25,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
