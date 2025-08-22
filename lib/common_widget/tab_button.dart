import 'package:flutter/material.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../common/color_extension.dart';

class TabButton extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  final bool isSelected;
  final String icon;
  const TabButton({
    super.key,
    required this.ontap,
    required this.title,
    required this.isSelected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 15,
            width: 15,
            color: isSelected ? TColor.primary : TColor.placeholder,
          ),
          4.height,
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? TColor.primary : TColor.placeholder,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
