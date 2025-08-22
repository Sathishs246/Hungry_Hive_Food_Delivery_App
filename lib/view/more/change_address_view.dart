import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hungry_hive_food_app/common_widget/round_textfield.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../../common/color_extension.dart';

class ChangeAddressView extends StatefulWidget {
  const ChangeAddressView({super.key});

  @override
  State<ChangeAddressView> createState() => _ChangeAddressViewState();
}

class _ChangeAddressViewState extends State<ChangeAddressView> {
  GoogleMapController? _controller;

  final locations = const [LatLng(8.1833, 77.4119)];

  late List<MarkerData> _customMarkers;

  static const CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
    target: LatLng(8.189341, 77.417959), //Nagercoil
    zoom: 14.151926040649414,
  );

  @override
  void initState() {
    super.initState();
    _customMarkers = [
      MarkerData(
        marker: Marker(
          markerId: const MarkerId('id-1'),
          position: locations[0],
        ),
        child: _customMarker('Everywhere\nis a Widgets', Colors.blue),
      ),
    ];
  }

  _customMarker(String symbol, Color color) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Image.asset(
            'assets/images/map_pin.png',
            width: 35,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgColor,
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 4,
        title: const Text(
          "Change Address",
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
      ),

      body: CustomGoogleMapMarkerBuilder(
        screenshotDelay: const Duration(seconds: 1),
        customMarkers: _customMarkers,
        builder: (BuildContext context, Set<Marker>? markers) {
          if (markers == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kLake,
            compassEnabled: false,
            gestureRecognizers:
                Set()..add(
                  Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
                ),
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundTextfield(
                hintText: "Search Address",
                obscureText: false,
                prefix: Icon(Icons.search, color: TColor.primaryText),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  // your onTap logic
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/fav_icon.png',
                      width: 30,
                      height: 30,
                      color: TColor.primary,
                    ),
                    8.width,
                    Expanded(
                      child: Text(
                        "Choose a saved place",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Image.asset(
                      'assets/images/btn_next_1.png',
                      width: 15,
                      height: 15,
                      color: TColor.primaryText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
