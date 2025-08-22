import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../login/welcome_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtMobile = TextEditingController();
  final TextEditingController txtAddress = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (doc.exists) {
          final data = doc.data();
          if (data != null) {
            txtName.text = data['name'] ?? '';
            txtEmail.text = data['email'] ?? '';
            txtMobile.text = data['mobile'] ?? '';
            txtAddress.text = data['address'] ?? '';
          }
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': txtName.text.trim(),
          'email': txtEmail.text.trim(),
          'mobile': txtMobile.text.trim(),
          'address': txtAddress.text.trim(),
        }, SetOptions(merge: true));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile updated successfully!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: TColor.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      print('Error saving user data: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update profile!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: TColor.primary))
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 50,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Profile',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showSignOutDialog(context);
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: const Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    18.height,

                    // Profile Avatar
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: TColor.placeholder,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile_placeholder.png', // your asset path
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    4.height,

                    TextButton.icon(
                      onPressed: () async {
                        image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {});
                      },
                      icon: Icon(Icons.edit, color: TColor.primary, size: 16),
                      label: Text(
                        'Edit Photo',
                        style: TextStyle(color: TColor.primary, fontSize: 14),
                      ),
                    ),

                    //5.height,
                    Text(
                      'Hello, ${txtName.text.isNotEmpty ? txtName.text : 'User'}!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: TColor.primaryText,
                      ),
                    ),

                    10.height,

                    // Form Section
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoundTitleTextfield(
                            title: 'Name',
                            hintText: 'Enter Name',
                            controller: txtName,
                          ),
                          12.height,
                          RoundTitleTextfield(
                            title: 'Email',
                            hintText: 'Enter Email',
                            controller: txtEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          12.height,
                          RoundTitleTextfield(
                            title: 'Mobile No',
                            hintText: 'Enter Mobile No',
                            controller: txtMobile,
                            keyboardType: TextInputType.phone,
                          ),
                          12.height,
                          RoundTitleTextfield(
                            title: 'Address',
                            hintText: 'Enter Address',
                            controller: txtAddress,
                          ),
                          20.height,
                          RoundButton(
                            title: 'Save Changes',
                            onPressed: saveUserData,
                          ),
                        ],
                      ),
                    ),

                    20.height,
                  ],
                ),
              ),
    );
  }

  void showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TColor.primaryText,
              ),
            ),
            content: Text(
              'Are you sure you want to sign out?',
              style: TextStyle(color: TColor.secondaryText, fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('Cancel', style: TextStyle(color: TColor.primary)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  Get.back();
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => WelcomeView());
                },
                child: Text('Sign Out', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }
}
