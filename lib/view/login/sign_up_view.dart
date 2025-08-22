import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hungry_hive_food_app/common_widget/round_button.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import 'package:hungry_hive_food_app/view/login/login_view.dart';
import 'package:hungry_hive_food_app/view/login/otp_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_icon_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../services/auth_service.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpcontroller = TextEditingController();
  bool _loading = false;
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
                "Sign Up",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),

              Text(
                "Add your details to sign up",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              25.height,
              RoundTextfield(
                hintText: 'Name',
                controller: namecontroller,
                keyboardType: TextInputType.name,
                obscureText: false,
              ),
              20.height,
              RoundTextfield(
                hintText: 'Email',
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              20.height,
              RoundTextfield(
                hintText: 'Mobile No',
                controller: mobilecontroller,
                keyboardType: TextInputType.phone,
                obscureText: false,
              ),
              20.height,
              RoundTextfield(
                hintText: 'Address',
                controller: addresscontroller,
                keyboardType: TextInputType.phone,
                obscureText: false,
              ),
              20.height,
              RoundTextfield(
                hintText: 'Password',
                controller: passwordcontroller,

                obscureText: true,
              ),
              20.height,
              RoundTextfield(
                hintText: 'Confirm Password',
                controller: cpcontroller,

                obscureText: true,
              ),
              25.height,
              _loading
                  ? CircularProgressIndicator(color: TColor.primary)
                  : RoundButton(
                    onPressed: () async {
                      if (passwordcontroller.text != cpcontroller.text) {
                        Get.snackbar('Error', 'Passwords do not match');
                        return;
                      }

                      setState(() => _loading = true);

                      try {
                        await AuthService.registerUser(
                          name: namecontroller.text.trim(),
                          email: emailcontroller.text.trim(),
                          password: passwordcontroller.text.trim(),
                          mobile: mobilecontroller.text.trim(),
                          address: addresscontroller.text.trim(),
                        );

                        Get.snackbar(
                          'Success',
                          'Account created! Please log in.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: TColor.primary,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(12),
                          borderRadius: 8,
                        );

                        Get.off(
                          () => LoginView(
                            initialEmail: emailcontroller.text.trim(),
                          ),
                        );
                      } catch (e) {
                        Get.snackbar('Error', e.toString());
                      } finally {
                        setState(() => _loading = false);
                      }
                    },
                    title: "Sign Up",
                  ),

              30.height,
              TextButton(
                onPressed: () {
                  Get.off(LoginView());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an Account?  ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: TColor.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
