import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/color_extension.dart';
import '../../common_widget/fancy_search_bar.dart';
import '../../common_widget/round_textfield.dart';
import '../more/my_order_view.dart';
import 'menu_items_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final TextEditingController txtSearch = TextEditingController();

  final List<Map<String, String>> menuArr = [
    {"name": "Food", "image": "assets/images/menu_1.png", "items_count": "180"},
    {
      "name": "Beverages",
      "image": "assets/images/menu_2.png",
      "items_count": "120",
    },
    {
      "name": "Desserts",
      "image": "assets/images/menu_3.png",
      "items_count": "80",
    },
    {
      "name": "Promotions",
      "image": "assets/images/menu_4.png",
      "items_count": "230",
    },
  ];
  List<String> foodHints = [
    "Biryani",
    "Pizza",
    "Burger",
    "Fried Rice",
    "Cake",
    "Salad",
  ];

  Timer? hintTimer;
  String currentHint = "Search for Biryani";
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    hintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % foodHints.length;
        currentHint = "Search for ${foodHints[currentIndex]}";
      });
    });
  }

  @override
  void dispose() {
    hintTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: Column(
        children: [
          /// Header with gradient and cart button
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 20,
            ),
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

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(const MyOrderView());
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/shopping_cart.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Search Bar
          FancySearchBar(hintText: currentHint, controller: txtSearch),

          const SizedBox(height: 20),

          /// Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: menuArr.length,
              itemBuilder: (context, index) {
                final item = menuArr[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(MenuItemsView(mObj: item));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        /// Image
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Image.asset(
                            item["image"] ?? "",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),

                        /// Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"] ?? "",
                                  style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${item["items_count"]} items available",
                                  style: TextStyle(
                                    color: TColor.secondaryText,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// Arrow Icon
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: TColor.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: TColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
