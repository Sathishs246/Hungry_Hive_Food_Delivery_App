import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundIconButton extends StatelessWidget {
  final String title;
  final String icon;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const RoundIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 24, width: 24),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
