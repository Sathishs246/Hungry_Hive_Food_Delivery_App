import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import 'package:hungry_hive_food_app/view/more/trackorder_timeline_page.dart';
import 'package:lottie/lottie.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../home/home_view.dart';
import '../main_tabview/main_tabview.dart';
import '../order_tracking/order_tracking_dynamic_timeview.dart';

class CheckoutMessageView extends StatefulWidget {
  const CheckoutMessageView({super.key});

  @override
  State<CheckoutMessageView> createState() => _CheckoutMessageViewState();
}

class _CheckoutMessageViewState extends State<CheckoutMessageView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: Container(
        width: media.width,
        height: media.height,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close, color: TColor.primaryText, size: 25),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: media.width * 0.6,
                  height: media.width * 0.6,
                  child: Lottie.asset(
                    'assets/images/confetti_lottie.json',
                    repeat: true,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(
                  "assets/images/thank_you.png",
                  width: media.width * 0.5,
                ),
              ],
            ),
            25.height,
            Text(
              "Thank You!",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            8.height,
            Text(
              "for your order",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            25.height,
            Text(
              "Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order",
              textAlign: TextAlign.center,
              style: TextStyle(color: TColor.primaryText, fontSize: 15),
            ),
            35.height,
            RoundButton(
              title: "Track My Order",
              onPressed: () {
                Get.to(OrderTrackingDynamicTimeView());
              },
            ),
            TextButton(
              onPressed: () {
                Get.off(MainTabview());
              },
              child: Text(
                "Back To Home",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
