import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../common/color_extension.dart';

class RecentItems extends StatelessWidget {
  final Map rrObj;
  final VoidCallback onTap;
  const RecentItems({super.key, required this.rrObj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                rrObj["image"].toString(),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            8.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rrObj["name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        rrObj["type"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        " . ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 11,
                        ),
                      ),
                      // Text(
                      //   rrObj["food_type"],
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: TColor.secondaryText,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ],
                  ),
                  2.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/rate.png",
                        width: 10,
                        height: 10,
                        fit: BoxFit.cover,
                      ),
                      2.width,
                      Text(
                        rrObj["rate"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 12,
                        ),
                      ),
                      8.width,
                      Text(
                        "(${rrObj["rating"]} Ratings)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
