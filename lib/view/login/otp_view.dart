import 'package:flutter/material.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
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
                "We have sent an OTP to your Mobile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              15.height,
              Text(
                "Please check your mobile number 98******21\ncontinue to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              40.height,
              SizedBox(
                height: 60,
                child: OtpPinField(
                  key: _otpPinFieldController,

                  ///in case you want to enable autoFill
                  autoFillEnable: true,

                  ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
                  textInputAction: TextInputAction.done,

                  ///in case you want to change the action of keyboard
                  /// to clear the Otp pin Controller
                  onSubmit: (text) {
                    debugPrint('Entered pin is $text');

                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onChange: (text) {
                    debugPrint('Enter on change pin is $text');

                    /// return the entered pin
                  },
                  onCodeChanged: (code) {
                    debugPrint('onCodeChanged  is $code');
                  },

                  /// to decorate your Otp_Pin_Field
                  otpPinFieldStyle: OtpPinFieldStyle(
                    /// bool to show hints in pin field or not
                    showHintText: true,

                    /// to set the color of hints in pin field or not
                    // hintTextColor: Colors.red,

                    /// to set the text  of hints in pin field
                    // hintText: '1',

                    /// border color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBorderColor: TColor.secondaryText,

                    /// border color for active/focused Otp_Pin_Field
                    activeFieldBorderColor: TColor.primary,

                    /// Background Color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBackgroundColor: TColor.white,

                    /// Background Color for active/focused Otp_Pin_Field
                    activeFieldBackgroundColor: TColor.white,

                    /// Background Color for filled field pin box
                    // filledFieldBackgroundColor: Colors.green,

                    /// border Color for filled field pin box
                    // filledFieldBorderColor: Colors.green,
                    //
                    /// gradient border Color for field pin box
                    // activeFieldBorderGradient: LinearGradient(
                    //   colors: [Colors.black, Colors.redAccent],
                    // ),
                    // filledFieldBorderGradient: LinearGradient(
                    //   colors: [Colors.green, Colors.tealAccent],
                    // ),
                    // defaultFieldBorderGradient: LinearGradient(
                    //   colors: [Colors.orange, Colors.brown],
                    // ),
                    fieldBorderWidth: 3,
                  ),
                  maxLength: 4,

                  /// no of pin field
                  showCursor: true,

                  /// bool to show cursor in pin field or not
                  cursorColor: Colors.indigo,

                  /// to choose cursor color
                  upperChild: const Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.flutter_dash_outlined, size: 150),
                      SizedBox(height: 20),
                    ],
                  ),
                  // 123456

                  ///bool which manage to show custom keyboard
                  // showCustomKeyboard: true,

                  /// Widget which help you to show your own custom keyboard in place if default custom keyboard
                  // customKeyboard: Container(),
                  ///bool which manage to show default OS keyboard
                  // showDefaultKeyboard: true,

                  /// to select cursor width
                  cursorWidth: 3,

                  /// place otp pin field according to yourself
                  mainAxisAlignment: MainAxisAlignment.center,

                  /// predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
                  ///use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),
              ),
              30.height,
              RoundButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                title: 'Next',
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Did't Received?  ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Click Here",
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
