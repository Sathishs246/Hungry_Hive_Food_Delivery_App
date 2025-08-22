import 'package:flutter/material.dart';
import '../common/color_extension.dart';

enum RoundButtonType { bgPrimary, textprimary }

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double fontSize;
  final RoundButtonType type;

  const RoundButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.fontSize = 16,
    this.type = RoundButtonType.bgPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient:
              type == RoundButtonType.bgPrimary
                  ? const LinearGradient(
                    colors: [Color(0xFFFF7043), Color(0xFFFFA726)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color: type == RoundButtonType.textprimary ? TColor.white : null,
          border:
              type == RoundButtonType.textprimary
                  ? Border.all(color: TColor.primary, width: 1)
                  : null,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          title,
          style: TextStyle(
            color:
                type == RoundButtonType.bgPrimary
                    ? Colors.white
                    : TColor.primary,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
