import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? prefix;

  const RoundTextfield({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType,
    required this.obscureText,
    this.bgColor,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? TColor.textfield,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        cursorColor: TColor.primary,
        autocorrect: false,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefix,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: TColor.placeholder,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class RoundTitleTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? prefix;

  const RoundTitleTextfield({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.bgColor,
    this.prefix,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: TColor.secondaryText,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        RoundTextfield(
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
          obscureText: obscureText,
          bgColor: bgColor,
          prefix: prefix,
        ),
      ],
    );
  }
}
