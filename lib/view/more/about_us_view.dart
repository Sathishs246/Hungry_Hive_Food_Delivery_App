import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../../common/color_extension.dart';
import 'my_order_view.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  List<String> aboutTextArr = [
    "We serve delicious food crafted with love and quality ingredients for a memorable experience.",
    "Our chefs bring authentic flavors from around the world right to your plate.",
    "Committed to hygiene, health, and happy meals every day.",
    "Serving happiness since 2020 with passion and excellence.",
    "Your taste satisfaction is our daily mission and promise.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF7043), Color(0xFFFFA726)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TColor.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      Text(
                        "About Us",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Get.to(MyOrderView()),
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            20.height,

            // Intro image or banner
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/banner.png",
                width: MediaQuery.of(context).size.width * 0.9,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
            20.height,

            // About items
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: aboutTextArr.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: TColor.primary,
                          size: 20,
                        ),
                        12.width,
                        Expanded(
                          child: Text(
                            aboutTextArr[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: TColor.primaryText,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            30.height,
          ],
        ),
      ),
    );
  }
}
