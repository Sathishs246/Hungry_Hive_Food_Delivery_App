import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import 'change_address_view.dart';
import 'checkout_message_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';
import '../../controller/cart_controller.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final cartController = Get.find<CartController>();
  List paymentArr = [
    {"name": "Cash on delivery", "icon": "assets/images/indian_cash.png"},
    {"name": "**** **** **** 2187", "icon": "assets/images/visa_icon.png"},
    {"name": "test@gmail.com", "icon": "assets/images/paypal.png"},
  ];

  late Razorpay _razorpay;

  final double deliveryCost = 150;
  final double discount = 100;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.to(() => CheckoutMessageView());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", response.message ?? "Unknown error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", response.walletName ?? "No wallet");
  }

  int selectMethod = 1;

  @override
  Widget build(BuildContext context) {
    double subTotal = cartController.totalPrice;
    double total = subTotal + deliveryCost - discount;

    return Scaffold(
      backgroundColor: TColor.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF7043), Color(0xFFFFA726)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              title: "Delivery Address",
              content: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Nagercoil",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(ChangeAddressView()),
                    child: Text(
                      "Change",
                      style: TextStyle(
                        color: TColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            16.height,
            Text(
              "Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            8.height,
            ListView.builder(
              itemCount: paymentArr.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var p = paymentArr[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Image.asset(p['icon'], width: 40),
                    title: Text(
                      p['name'],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Radio(
                      value: index,
                      groupValue: selectMethod,
                      onChanged: (val) => setState(() => selectMethod = index),
                      activeColor: TColor.primary,
                    ),
                  ),
                );
              },
            ),
            16.height,
            _buildCard(
              title: "Order Summary",
              content: Column(
                children: [
                  _buildRow("Sub Total", "₹${subTotal.toStringAsFixed(2)}"),
                  _buildRow(
                    "Delivery Cost",
                    "₹${deliveryCost.toStringAsFixed(2)}",
                  ),
                  _buildRow("Discount", "-₹${discount.toStringAsFixed(2)}"),
                  Divider(),
                  _buildRow(
                    "Total",
                    "₹${total.toStringAsFixed(2)}",
                    isTotal: true,
                  ),
                ],
              ),
            ),
            24.height,
            RoundButton(
              title: "Pay Now",
              onPressed: () {
                var options = {
                  'key': 'rzp_test_xz4KhfnrxFpSAn',
                  'amount': (total * 100).toInt(),
                  'name': 'Hungry Hive',
                  'description': 'Food Order Payment',
                  'prefill': {
                    'contact': '9876543210',
                    'email': 'test@example.com',
                  },
                  'method': {'googlepay': true},
                  'theme': {'color': '#FC6011'},
                };
                try {
                  _razorpay.open(options);
                } catch (e) {
                  debugPrint('Error: $e');
                }
              },
            ),
            40.height,
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget content}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            8.height,
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? TColor.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
