import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:audioplayers/audioplayers.dart';

class LiveTrackingView extends StatefulWidget {
  const LiveTrackingView({super.key});

  @override
  State<LiveTrackingView> createState() => _LiveTrackingViewState();
}

class _LiveTrackingViewState extends State<LiveTrackingView> {
  GoogleMapController? _mapController;

  final LatLng _startLocation = const LatLng(8.181652, 77.415911);
  final LatLng _destinationLocation = const LatLng(8.189341, 77.417959);
  late List<LatLng> _routePoints;
  int _currentIndex = 0;
  Timer? _moveTimer;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // ✅ Initialize audio player
    _routePoints = _generateRoute(_startLocation, _destinationLocation);
    //_startMovingAlongRoute();
  }

  List<LatLng> _generateRoute(LatLng start, LatLng end) {
    List<LatLng> points = [];
    const steps = 50;
    for (int i = 0; i <= steps; i++) {
      double lat = _lerp(start.latitude, end.latitude, i / steps);
      double lng = _lerp(start.longitude, end.longitude, i / steps);
      points.add(LatLng(lat, lng));
    }
    return points;
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  void _startMovingAlongRoute() {
    _moveTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_currentIndex < _routePoints.length - 1) {
        _currentIndex++;
        setState(() {});
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(_routePoints[_currentIndex]),
        );
      } else {
        timer.cancel();
        _onDeliveryCompleted();
      }
    });
  }

  void _onDeliveryCompleted() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Slight delay
    await _audioPlayer.play(AssetSource('sounds/iphone_ring.mp4'));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/delivery_boy.png"),
              ),
              const SizedBox(height: 10),
              const Text(
                "Delivery Boy Calling...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                "📞 +91 98210 12345",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text(
                      "Answer",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _audioPlayer.stop();
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.call_end, color: Colors.white),
                    label: const Text(
                      "Decline",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _audioPlayer.stop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _moveTimer?.cancel();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = _routePoints[_currentIndex];
    double progress = (_currentIndex / (_routePoints.length - 1)).clamp(
      0.0,
      1.0,
    );
    int remainingMinutes = ((1.0 - progress) * 19).ceil();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 6,
        title: const Text(
          "Tracking",
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _startLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;

              Future.delayed(const Duration(seconds: 3), () {
                _startMovingAlongRoute();
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId("delivery_boy"),
                position: currentPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
                infoWindow: const InfoWindow(title: "Delivery Boy"),
              ),
              Marker(
                markerId: const MarkerId("destination"),
                position: _destinationLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
                infoWindow: const InfoWindow(title: "Your Location"),
              ),
            },
            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                color: Colors.redAccent,
                width: 5,
                points: _routePoints,
              ),
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/images/delivery.json',
                    height: 100,
                    repeat: true,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    color: Colors.deepOrange,
                    backgroundColor: Colors.orange.shade100,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Delivery in $remainingMinutes mins • ${(progress * 100).toInt()}% completed",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
