import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import '../../common/color_extension.dart';
import 'my_order_view.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List notificationArr = [
    {
      "title": "Your order has been picked up",
      "time": "Now",
      "icon": Icons.delivery_dining,
    },
    {
      "title": "Your order has been delivered",
      "time": "1h ago",
      "icon": Icons.check_circle_outline,
    },
    {
      "title": "Your order is on the way",
      "time": "3h ago",
      "icon": Icons.local_shipping_outlined,
    },
    {
      "title": "Your order has been delivered",
      "time": "5h ago",
      "icon": Icons.check_circle_outline,
    },
    {
      "title": "Your order is being prepared",
      "time": "05 Aug 2025",
      "icon": Icons.kitchen_outlined,
    },
    {
      "title": "Your order has been delivered",
      "time": "05 Aug 2025",
      "icon": Icons.check_circle_outline,
    },
    {
      "title": "Delivery boy is arriving",
      "time": "04 Aug 2025",
      "icon": Icons.directions_bike,
    },
    {"title": "Order completed", "time": "06 Jun 2025", "icon": Icons.verified},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [TColor.primary, TColor.primary.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
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
                      "Notifications",
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: notificationArr.length,
              separatorBuilder: (context, index) => 10.height,
              itemBuilder: (context, index) {
                final item = notificationArr[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: TColor.primary.withOpacity(0.1),
                        child: Icon(
                          item["icon"],
                          color: TColor.primary,
                          size: 24,
                        ),
                      ),
                      16.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: TColor.primaryText,
                              ),
                            ),
                            6.height,
                            Text(
                              item["time"],
                              style: TextStyle(
                                fontSize: 12,
                                color: TColor.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
