import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import '../common/color_extension.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({Key? key}) : super(key: key);

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String? _locationLabel;
  bool _loading = false;

  Future<void> _fetchLocationFromFirebase() async {
    setState(() {
      _loading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _locationLabel = "Not logged in";
          _loading = false;
        });
        return;
      }

      // Get user document from Firestore
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        String? location = data?['address']; // Field name in Firestore

        setState(() {
          _locationLabel = location ?? "Location not set";
          _loading = false;
        });
      } else {
        setState(() {
          _locationLabel = "No location found";
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _locationLabel = "Error fetching location";
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLocationFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Location',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: _loading ? null : _fetchLocationFromFirebase,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: Colors.orange, size: 20),
                const SizedBox(width: 6),
                _loading
                    ? Shimmer.fromColors(
                      baseColor: TColor.secondaryText.withOpacity(0.3),
                      highlightColor: TColor.primary.withOpacity(0.2),
                      child: Container(
                        width: 220,
                        height: 16,
                        color: Colors.white,
                      ),
                    )
                    : Flexible(
                      child: Text(
                        _locationLabel ?? 'Tap to get location',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
