import 'package:flutter/material.dart';

class CategoryCell extends StatelessWidget {
  final Map cObj;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryCell({
    Key? key,
    required this.cObj,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.yellow : Colors.grey.shade300,
                width: 3,
              ),
            ),
            child: AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: Duration(milliseconds: 300),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(cObj["image"].toString()),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            cObj["name"].toString(),
            style: TextStyle(
              color: isSelected ? Colors.yellow.shade800 : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
