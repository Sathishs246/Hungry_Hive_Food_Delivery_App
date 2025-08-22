import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoupenCardView extends StatelessWidget {
  const CoupenCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        title: const Text(
          "Coupon & Voucher",
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
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCouponCard(
            label: "CASHBACK",
            labelColor: Colors.orange,
            title: "CWCINDPAYTM",
            description:
                "Flat ₹100 Cashback Using Paytm Wallet on orders above ₹500.",
          ),
          const SizedBox(height: 16),
          _buildCouponCard(
            label: "20% OFF",
            labelColor: Colors.deepOrangeAccent,
            title: "KOTAK125",
            description:
                "Save ₹113 using Kotak Debit Cards. Max discount ₹125 on ₹500+ orders.",
          ),
          const SizedBox(height: 16),
          _buildCouponCard(
            label: "CASHBACK",
            labelColor: Colors.pinkAccent,
            title: "INDWALLET",
            description:
                "₹150 Cashback via Wallet. Valid on selected payment modes only.",
          ),
          const SizedBox(height: 16),
          _buildCouponCard(
            label: "CASHBACK",
            labelColor: Colors.blue,
            title: "CWCINDPAYTM",
            description:
                "Flat ₹100 Cashback Using Paytm Wallet on orders above ₹500.",
          ),
          const SizedBox(height: 16),
          _buildCouponCard(
            label: "20% OFF",
            labelColor: Colors.green,
            title: "KOTAK125",
            description:
                "Save ₹113 using Kotak Debit Cards. Max discount ₹125 on ₹500+ orders.",
          ),
          const SizedBox(height: 16),
          _buildCouponCard(
            label: "CASHBACK",
            labelColor: Colors.deepPurple,
            title: "INDWALLET",
            description:
                "₹150 Cashback via Wallet. Valid on selected payment modes only.",
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({
    required String label,
    required Color labelColor,
    required String title,
    required String description,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(50, 18, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Apply
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "+ More Info",
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        // Vertical Label
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 30,
            decoration: BoxDecoration(
              color: labelColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
