import 'package:flutter/material.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';

import '../../common/color_extension.dart';
import '../../common_widget/tab_button.dart';
import '../more/more_view.dart';
import '../offer/offer_view.dart';
import '../home/home_view.dart';
import '../menu/menu_view.dart';
import '../profile/profile_view.dart';

class MainTabview extends StatefulWidget {
  const MainTabview({super.key});

  @override
  State<MainTabview> createState() => _MainTabviewState();
}

class _MainTabviewState extends State<MainTabview> {
  int _selectTab = 2;
  PageStorageBucket storageBucket = PageStorageBucket();
  Widget selectPageView = const HomeView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: PageStorage(bucket: storageBucket, child: selectPageView),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            if (_selectTab != 2) {
              _selectTab = 2;
              selectPageView = const HomeView();
            }
            if (mounted) {
              setState(() {});
            }
          },
          shape: const CircleBorder(),
          backgroundColor:
              _selectTab == 2 ? TColor.primary : TColor.placeholder,
          child: Image.asset(
            "assets/images/tab_home.png",
            width: 30,
            height: 30,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: TColor.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
        notchMargin: 12,
        height: 64,
        shape: const CircularNotchedRectangle(),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                ontap: () {
                  if (_selectTab != 0) {
                    _selectTab = 0;
                    selectPageView = const MenuView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'Menu',
                isSelected: _selectTab == 0,
                icon: "assets/images/tab_menu.png",
              ),
              TabButton(
                ontap: () {
                  if (_selectTab != 1) {
                    _selectTab = 1;
                    selectPageView = const OfferView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'Offer',
                isSelected: _selectTab == 1,
                icon: "assets/images/tab_offer.png",
              ),
              SizedBox(width: 40, height: 40),

              TabButton(
                ontap: () {
                  if (_selectTab != 3) {
                    _selectTab = 3;
                    selectPageView = const ProfileView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'Profile',
                isSelected: _selectTab == 3,
                icon: "assets/images/tab_profile.png",
              ),
              TabButton(
                ontap: () {
                  if (_selectTab != 4) {
                    _selectTab = 4;
                    selectPageView = MoreView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'More',
                isSelected: _selectTab == 4,
                icon: "assets/images/tab_more.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
