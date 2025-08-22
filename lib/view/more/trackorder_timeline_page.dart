import 'package:flutter/material.dart';

class TrackOrderTimelinePage extends StatefulWidget {
  @override
  _TrackOrderTimelinePageState createState() => _TrackOrderTimelinePageState();
}

class _TrackOrderTimelinePageState extends State<TrackOrderTimelinePage> {
  final List<Map<String, dynamic>> steps = [
    {'title': 'Order Placed', 'time': '10:00 AM', 'isDone': true},
    {'title': 'Preparing Food', 'time': '10:15 AM', 'isDone': true},
    {'title': 'Out for Delivery', 'time': '', 'isDone': false},
    {'title': 'Delivered', 'time': '', 'isDone': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track My Order"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: steps.length,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemBuilder: (context, index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;
          final isDone = step['isDone'] ?? false;
          final time = step['time'] ?? '';

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Dot + Line
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? Colors.white : Colors.grey.shade300,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 50,
                      color: isDone ? Colors.green : Colors.grey.shade300,
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Title + Time
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDone ? Colors.black : Colors.grey,
                        ),
                        child: Text(step['title']),
                      ),
                      if (time.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            time,
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
            ],
          );
        },
      ),
    );
  }
}
