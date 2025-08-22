import 'package:flutter/material.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

TextEditingController passwordcontroller = TextEditingController();
TextEditingController cpcontroller = TextEditingController();

class _NewPasswordViewState extends State<NewPasswordView> {
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
                "New Password",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              15.height,
              Text(
                "Please enter your new password",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              40.height,
              RoundTextfield(
                hintText: 'New Password',
                controller: passwordcontroller,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              25.height,

              RoundTextfield(
                hintText: 'Confirm Password',
                controller: cpcontroller,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              30.height,
              RoundButton(onPressed: () {}, title: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
