import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_icon_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../extension/spacingextension.dart';
import '../../services/auth_service.dart';
import '../home/home_view.dart';
import '../login/reset_password_view.dart';
import '../login/sign_up_view.dart';
import '../main_tabview/main_tabview.dart';
import '../on_boarding/on_boarding_view.dart';

class LoginView extends StatefulWidget {
  final String? initialEmail;

  const LoginView({super.key, this.initialEmail});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialEmail != null) {
      emailController.text = widget.initialEmail!;
    }
    //_checkLoggedIn();
  }

  // void _checkLoggedIn() {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       Get.offAll(() => const MainTabview());
  //     });
  //   }
  // }

  Future<void> _login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password.',
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _loading = true;
    });
    try {
      await AuthService.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAll(() => const OnBoardingView());
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                10.height,
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: 1,
                  child: Image.asset(
                    'assets/images/hungryhive_logo.png',
                    width: media.width * 0.35,
                  ),
                ),
                20.height,
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: TColor.textfield,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      6.height,
                      Text(
                        "Add your details to login",
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 14,
                        ),
                      ),
                      25.height,
                      RoundTextfield(
                        hintText: 'Email Address',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        bgColor: Colors.white,
                      ),
                      20.height,
                      RoundTextfield(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: true,
                        //autofocus: widget.initialEmail != null,
                        bgColor: Colors.white,
                      ),
                      15.height,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => const ResetPasswordView());
                          },
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: TColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      10.height,
                      _loading
                          ? CircularProgressIndicator(color: TColor.primary)
                          : RoundButton(title: "Login", onPressed: _login),
                      20.height,
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: TColor.secondaryText.withOpacity(0.4),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "or Login With",
                              style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: TColor.secondaryText.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      20.height,
                      RoundIconButton(
                        title: 'Login with Facebook',
                        icon: 'assets/images/facebook_logo.png',
                        color: const Color(0xFF3b5998),
                        onPressed: () {},
                      ),
                      15.height,
                      RoundIconButton(
                        title: 'Login with Google',
                        icon: 'assets/images/google_logo.png',
                        color: const Color(0xffDD4B39),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                6.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SignUpView());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: TColor.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
