import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/common/color_extension.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import 'my_order_view.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView>
    with SingleTickerProviderStateMixin {
  List<Map<String, String>> inboxArr = List.generate(
    10,
    (index) => {
      "title": "Hungry Hive Promotions",
      "detail":
          "🎉 Get 30% OFF on your next meal! Limited time offer. Tap to know more!",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
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
                      "Inbox",
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

          /// Inbox List
          Expanded(
            child: ListView.builder(
              itemCount: inboxArr.length,
              itemBuilder: (context, index) {
                final item = inboxArr[index];

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300 + index * 100),
                  curve: Curves.easeIn,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: TColor.primary.withOpacity(0.1),
                      child: const Icon(
                        Icons.campaign_rounded,
                        color: Colors.orange,
                      ),
                    ),
                    title: Text(
                      item['title'] ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: TColor.primaryText,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        item['detail'] ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: TColor.secondaryText,
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.snackbar("Offer", "Thanks for checking this out!");
                    },
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
