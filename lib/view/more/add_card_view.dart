import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/common_widget/round_icon_button.dart';
import 'package:hungry_hive_food_app/common_widget/round_textfield.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../../common/color_extension.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key});

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  TextEditingController txtCardNumber = TextEditingController();
  TextEditingController txtCardMonth = TextEditingController();
  TextEditingController txtCardYear = TextEditingController();
  TextEditingController txtCardCode = TextEditingController();
  TextEditingController txtCardFirstName = TextEditingController();
  TextEditingController txtCardLastName = TextEditingController();
  bool isAnyTime = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      width: media.width,

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add Credit/debit Card",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close, color: TColor.primaryText, size: 25),
              ),
            ],
          ),
          Divider(height: 1, color: TColor.secondaryText.withOpacity(0.4)),
          15.height,
          RoundTextfield(
            hintText: "Card Number",
            obscureText: false,
            controller: txtCardNumber,
            keyboardType: TextInputType.number,
          ),
          15.height,

          Row(
            children: [
              Text(
                "Expiry",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 100,
                child: RoundTextfield(
                  hintText: "MM",
                  obscureText: false,
                  controller: txtCardMonth,
                  keyboardType: TextInputType.number,
                ),
              ),
              25.width,
              SizedBox(
                width: 100,
                child: RoundTextfield(
                  hintText: "YYYY",
                  obscureText: false,
                  controller: txtCardYear,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          15.height,
          RoundTextfield(
            hintText: "Card Security",
            obscureText: false,
            controller: txtCardCode,
            keyboardType: TextInputType.number,
          ),

          15.height,
          RoundTextfield(
            hintText: "First Name",
            obscureText: false,
            controller: txtCardFirstName,
          ),

          15.height,
          RoundTextfield(
            hintText: "Last Name",
            obscureText: false,
            controller: txtCardLastName,
          ),

          15.height,
          Row(
            children: [
              Text(
                "You can remove this card at anytime",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Switch(
                value: isAnyTime,
                activeColor: TColor.primary,
                onChanged: (newValue) {
                  setState(() {
                    isAnyTime = newValue;
                  });
                },
              ),
            ],
          ),
          25.height,
          RoundIconButton(
            title: "Add Card",
            icon: "assets/images/add.png",
            color: TColor.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            onPressed: () {},
          ),
          25.height,
        ],
      ),
    );
  }
}
