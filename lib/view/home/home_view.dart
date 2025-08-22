import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hive_food_app/extension/spacingextension.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/color_extension.dart';

import '../../common_widget/fancy_search_bar.dart';
import '../../common_widget/gradient_text.dart';
import '../../common_widget/most_popular_cell.dart';
import '../../common_widget/popular_resutaurant_row.dart';
import '../../common_widget/recent_items.dart';

import '../../common_widget/view_all_title_row.dart';
import '../../services/location_selector.dart';
import '../more/my_order_view.dart';

import 'banner_page_view.dart';
import 'coupen_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int innerCurrentPage = 0;
  List<String> foodHints = [
    "Biryani",
    "Pizza",
    "Burger",
    "Fried Rice",
    "Cake",
    "Salad",
  ];
  String currentHint = "Search for Biryani";
  int currentIndex = 0;
  Timer? hintTimer;
  TextEditingController txtSearch = TextEditingController();
  // final List<String> casualGreetings = [
  //   "Hello",
  //   "Hey there",
  //   "Welcome back",
  //   "What's up",
  //   "Howdy",
  //   "Yo",
  // ];
  final List<String> casualGreetings = ["Hey "];
  String userName = '';
  late String selectedGreeting;
  int selectedIndex = 2;

  Future<void> fetchUserName() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        setState(() {
          userName = doc.data()?['name'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    hintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % foodHints.length;
        currentHint = "Search for ${foodHints[currentIndex]}";
      });
    });
    selectedGreeting =
        casualGreetings[DateTime.now().millisecond % casualGreetings.length];
    fetchUserName();
  }

  @override
  void dispose() {
    hintTimer?.cancel();
    super.dispose();
  }

  final List<Map<String, dynamic>> categories = [
    {"name": "Burger", "icon": "assets/images/burgerc.png"},
    {"name": "Pizza", "icon": "assets/images/pizzac.png"},
    {"name": "Fries", "icon": "assets/images/friesc.png"},
    {"name": "Drinks", "icon": "assets/images/drinksc.png"},
    {"name": "Meat", "icon": "assets/images/meatc.png"},
  ];
  List popArr = [
    {
      "image": "assets/images/mutton_biriyani_recipe.jpeg",
      "name": "Hyderabadi heat, Tamil treat!",
      "rate": "4.9",
      "rating": "260",
      "type": "Special",
      "food_type": "Indian Food",
    },
    {
      "image": "assets/images/onam_food.jpg",
      "name": "Onam Vibes, Kerala Tribes!",
      "rate": "4.9",
      "rating": "350",
      "type": "Festival",
      "food_type": "Indian Food",
    },
    {
      "image": "assets/images/res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "185",
      "type": "Domino's",
      "food_type": "Western Food",
    },
    {
      "image": "assets/images/res_2.png",
      "name": "Cafe de Noir",
      "rate": "4.7",
      "rating": "165",
      "type": "Cafa",
      "food_type": "Western Food",
    },
    {
      "image": "assets/images/res_3.png",
      "name": "Bakes by Tella",
      "rate": "4.6",
      "rating": "143",
      "type": "Cafa",
      "food_type": "Western Food",
    },
  ];

  List mostPopArr = [
    {
      "image": "assets/images/mutton_biriyani_recipe.jpeg",
      "name": "Hyderabadi heat, Tamil treat!",
      "rate": "4.9",
      "rating": "260",
      "type": "Festival",
      "food_type": "Indian Food",
    },
    {
      "image": "assets/images/m_res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "185",
      "type": "Cafa",
      "food_type": "Western Food",
    },
    {
      "image": "assets/images/m_res_2.png",
      "name": "Cafe de Noir",
      "rate": "4.7",
      "rating": "165",
      "type": "Cafa",
      "food_type": "Western Food",
    },
    {
      "image": "assets/images/onam_food.jpg",
      "name": "Onam Vibes, Kerala Tribes!",
      "rate": "4.9",
      "rating": "350",
      "type": "Cafa",
      "food_type": "Indian Food",
    },
    {
      "image": "assets/images/res_3.png",
      "name": "Bakes by Tella",
      "rate": "4.6",
      "rating": "143",
      "type": "Cafa",
      "food_type": "Western Food",
    },
  ];
  List recentArr = [
    {
      "image": "assets/images/item_1.png",
      "name": "Mulberry Pizza by Josh",
      "rate": "4.9",
      "rating": "185",
      "type": "Cafa",
      "food_type": "Western Food",
    },
    {
      "image": "assets/images/item_2.png",
      "name": "Barita",
      "rate": "4.7",
      "rating": "165",
      "type": "Cafa",
      "food_type": "Western Food",
    },
    {
      "image": "assets/images/item_3.png",
      "name": "Pizza Rush Hour",
      "rate": "4.6",
      "rating": "143",
      "type": "Cafa",
      "food_type": "Western Food",
    },
  ];
  List menuItemsArr = [
    {
      "image": "assets/images/dess_1.png",
      "name": "French Apple Pie",
      "rate": "4.9",
      "rating": "185",
      "type": "Minute by tuk tuk",
    },
    {
      "image": "assets/images/dess_2.png",
      "name": "Dark Chocolate Cake",
      "rate": "4.7",
      "rating": "165",
      "type": "Cakes by Tella",
    },
    {
      "image": "assets/images/dess_3.png",
      "name": "Street Shake",
      "rate": "4.6",
      "rating": "143",
      "type": "Cafe Racer",
    },
    {
      "image": "assets/images/dess_4.png",
      "name": "Fudgy Chewy Brownies",
      "rate": "4.6",
      "rating": "143",
      "type": "Minute by tuk tuk",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              46.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userName.isEmpty
                        ? Shimmer.fromColors(
                          baseColor: TColor.secondaryText.withOpacity(0.3),
                          highlightColor: TColor.primary.withOpacity(0.2),
                          child: Container(
                            width: 180,
                            height: 20,
                            color: Colors.white,
                          ),
                        )
                        : RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: TColor.primaryText,
                            ),
                            children: [
                              TextSpan(text: '$selectedGreeting '),
                              if (userName.isNotEmpty)
                                TextSpan(
                                  text: userName,
                                  style: TextStyle(
                                    foreground:
                                        Paint()
                                          ..shader = LinearGradient(
                                            colors: [
                                              Colors.deepOrange,
                                              Colors.orange,
                                            ],
                                          ).createShader(
                                            const Rect.fromLTWH(0, 0, 200, 70),
                                          ),
                                  ),
                                ),
                              const TextSpan(text: ' !'),
                            ],
                          ),
                        ),
                    Spacer(),
                    // Gift icon
                    _buildGlassIcon(
                      icon: Icons.card_giftcard,
                      color: Colors.red,
                      onTap: () => Get.to(CoupenCardView()),
                    ),

                    const SizedBox(width: 8),

                    // Cart icon
                    _buildGlassIcon(
                      iconWidget: Image.asset(
                        "assets/images/shopping_cart.png",
                        width: 20,
                        height: 20,
                      ),
                      onTap: () => Get.to(MyOrderView()),
                    ),
                  ],
                ),
              ),
              10.height,
              const LocationSelector(),

              10.height,

              FancySearchBar(hintText: currentHint, controller: txtSearch),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'A ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GradientText(
                          text: 'special dish',
                          gradient: LinearGradient(
                            colors: [Colors.deepOrange, Colors.orange.shade300],
                          ),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' prepared for you',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              BannerPageView(),
              20.height,
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    final isSelected = index == selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.yellow.shade100
                                        : Colors.grey.shade200,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.orange
                                          : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Image.asset(
                                item["icon"],
                                width: 40,
                                height: 40,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item["name"],
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.orange : Colors.black,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Restaurants',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: TColor.primaryText,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // View All Action
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 14,
                          color: TColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: popArr.length,
                itemBuilder: (context, index) {
                  var pObj = popArr[index] as Map? ?? {};
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PopularRestaurantCard(
                      data: pObj,
                      onTap: () {
                        // Handle tap
                      },
                    ),
                  );
                },
              ),

              // TITLE ROW
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Most Popular',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: TColor.primaryText,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle "View All" tap
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 14,
                          color: TColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // HORIZONTAL LIST
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: mostPopArr.length,
                  itemBuilder: (context, index) {
                    var mObj = mostPopArr[index] as Map? ?? {};
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: MostPopularCard(
                        data: mObj,
                        onTap: () {
                          // Navigate to details
                        },
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(title: 'Recent Items', onView: () {}),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: menuItemsArr.length,
                itemBuilder: ((context, index) {
                  var rrObj = menuItemsArr[index] as Map? ?? {};
                  return RecentItems(rrObj: rrObj, onTap: () {});
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildGlassIcon({
  IconData? icon,
  Widget? iconWidget,
  Color? color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
        ],
        //backdropFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      ),
      padding: const EdgeInsets.all(8),
      child: iconWidget ?? Icon(icon, color: color ?? Colors.black),
    ),
  );
}
