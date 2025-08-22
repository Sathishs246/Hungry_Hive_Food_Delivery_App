import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../common/color_extension.dart';
import 'live_tracking_view.dart';

class OrderTrackingDynamicTimeView extends StatefulWidget {
  const OrderTrackingDynamicTimeView({super.key});

  @override
  State<OrderTrackingDynamicTimeView> createState() =>
      _OrderTrackingDynamicTimeViewState();
}

class _OrderTrackingDynamicTimeViewState
    extends State<OrderTrackingDynamicTimeView> {
  late List<Map<String, dynamic>> steps;
  Timer? _timer;
  int currentStepIndex = 0;
  bool showAnimation = false;

  @override
  void initState() {
    super.initState();
    steps = [
      {'title': 'Confirm Your Order', 'time': '', 'isDone': false},
      {'title': 'Shipper Going to Restaurant', 'time': '', 'isDone': false},
      {'title': 'Restaurant Handing Over', 'time': '', 'isDone': false},
      {'title': 'Shipping in Progress', 'time': '', 'isDone': false},
      {'title': 'Delivered to Your Address', 'time': '', 'isDone': false},
    ];
    _startTimeLine();
  }

  void _startTimeLine() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentStepIndex < steps.length) {
        setState(() {
          steps[currentStepIndex]['time'] = DateFormat.Hms().format(
            DateTime.now(),
          );
          steps[currentStepIndex]['isDone'] = true;
          currentStepIndex++;
        });
      } else {
        _timer?.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            showAnimation = true;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double get progressPercent => currentStepIndex / steps.length;

  Widget buildStep(Map<String, dynamic> step, bool isLast) {
    final isDone = step['isDone'] == true;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? TColor.primary : Colors.grey.shade300,
              ),
              padding: const EdgeInsets.all(6),
              child: Icon(
                isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                color: Colors.white,
                size: 20,
              ),
            ),
            if (!isLast)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 2,
                height: 50,
                color: isDone ? TColor.primary : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDone ? Colors.black : Colors.grey,
                    ),
                  ),
                  if ((step['time'] as String).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        step['time'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final percent = (progressPercent * 100).toStringAsFixed(0);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 6,
        title: const Text(
          "Live Order Tracking",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Timeline Steps
            Expanded(
              child: ListView.builder(
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  return buildStep(steps[index], index == steps.length - 1);
                },
              ),
            ),

            /// Progress Bar
            // Text(
            //   "$percent% Completed",
            //   style: const TextStyle(fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 8),
            // LinearProgressIndicator(
            //   value: progressPercent,
            //   backgroundColor: Colors.grey[300],
            //   color: TColor.primary,
            //   minHeight: 8,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            // const SizedBox(height: 20),

            /// Lottie + Track Button
            if (showAnimation) ...[
              const SizedBox(height: 10),
              SizedBox(
                height: 230,
                child: Lottie.asset("assets/images/delivery_riding.json"),
              ),
            ],

            SizedBox(
              height: 60,
              width: 400,
              child: ElevatedButton.icon(
                onPressed: () => Get.to(const LiveTrackingView()),
                icon: const Icon(
                  Icons.location_pin,
                  color: Colors.white,
                  size: 24,
                ),
                label: const Text(
                  "Track Your Order",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColor.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
