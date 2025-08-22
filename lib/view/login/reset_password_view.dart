import 'package:flutter/material.dart';
import 'package:hungry_hive_food_app/common_widget/round_button.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import 'package:get/get.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_textfield.dart';
import 'new_password_view.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

TextEditingController emailcontroller = TextEditingController();

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              64.height,
              Text(
                "Reset Password",

                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              15.height,
              Text(
                "Please enter your email to receive a\nlink to create a new password via email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              40.height,
              RoundTextfield(
                hintText: 'Your Email',
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              30.height,
              RoundButton(
                onPressed: () {
                  Get.to(NewPasswordView());
                },
                title: 'Send',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
