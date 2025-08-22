import 'package:flutter/material.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/view/login/sign_up_view.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import 'login_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  "assets/images/welcome_top_shape.png",
                  width: media.width,
                ),

                Image.asset(
                  "assets/images/hungryhive_logo.png",
                  width: media.width * 0.55,
                  height: media.height * 0.25,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: media.width * 0.1),
            Text(
              'Welcome to the Hive of Delicious Bites 🐝',
              style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: media.width * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundButton(
                onPressed: () {
                  Get.to(LoginView());
                },
                title: 'Login',
              ),
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundButton(
                onPressed: () {
                  Get.to(SignUpView());
                },
                title: 'Create an Account',
                type: RoundButtonType.textprimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
