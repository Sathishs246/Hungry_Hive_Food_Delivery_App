import 'dart:convert';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../common/color_extension.dart';
import '../../controller/cart_controller.dart';
import '../../controller/favorite_controller.dart';
import '../../model/recipe_model.dart';
import '../more/my_order_view.dart';
import 'item_details_view.dart';

///Let me know if you want to animate the cart icon or show a badge on the top bar!
class MenuItemsView extends StatefulWidget {
  final Map mObj;
  const MenuItemsView({super.key, required this.mObj});

  @override
  State<MenuItemsView> createState() => _MenuItemsViewState();
}

class _MenuItemsViewState extends State<MenuItemsView> {
  List recipes = [];
  bool isLoading = true;
  final Set<int> favoriteIndexes = {}; // Track favorites globally
  final cart = Get.find<CartController>();
  final cartController =
      Get.find<CartController>(); // Or put this in your build
  final favController = Get.find<FavoriteController>();
  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recipes = data['recipes'];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to load recipes');
    }
  }

  List getRecipesForTab(int tabIndex) {
    int start = tabIndex * 10;
    int end = (start + 10).clamp(0, recipes.length);
    return recipes.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: TColor.bgColor,
        body: Column(
          children: [
            _buildHeader(),
            isLoading
                ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
                : Expanded(
                  child: TabBarView(
                    children: [
                      buildGridView(getRecipesForTab(0)), // Meals
                      buildGridView(getRecipesForTab(1)), // Sides
                      buildGridView(getRecipesForTab(2)), // Snacks
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [TColor.primary, TColor.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _iconButton(Icons.arrow_back, () => Get.back()),
              const SizedBox(width: 12),
              Expanded(
                child: Center(
                  child: Text(
                    widget.mObj["name"].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Obx(
                () => badges.Badge(
                  badgeStyle: const badges.BadgeStyle(badgeColor: Colors.black),
                  position: badges.BadgePosition.topEnd(top: -4, end: -4),
                  showBadge: cartController.cartItems.isNotEmpty,
                  badgeAnimation: const badges.BadgeAnimation.scale(
                    animationDuration: Duration(milliseconds: 300),
                  ),
                  badgeContent: Text(
                    cartController.cartItems.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () => Get.to(const MyOrderView()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'Sides'), Tab(text: 'Meals'), Tab(text: 'Snacks')],
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget buildGridView(List dataList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GridView.builder(
        itemCount: dataList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.70,
        ),
        itemBuilder: (context, index) {
          final item = dataList[index];
          final globalIndex = recipes.indexOf(item);

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ItemDetailsScreen(recipe: Recipe.fromJson(item)),
                    );
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/Food_loading.gif',
                          image: item['image'],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Obx(
                            () => InkWell(
                              onTap:
                                  () =>
                                      favController.toggleFavorite(item['id']),
                              child: Image.asset(
                                favController.isFavorite(item['id'])
                                    ? "assets/images/favorites_btn.png"
                                    : "assets/images/favorites_btn_2.png",
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          item['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: Text(
                          '₹${item['caloriesPerServing']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          final cart = Get.find<CartController>();
                          cart.addToCart(
                            CartItem(
                              id: item['id'],
                              name: item['name'],
                              image: item['image'],
                              quantity: 1,
                              servings: item['servings'],
                              price:
                                  item['caloriesPerServing']
                                      .toDouble(), // change to correct field
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF7043), Color(0xFFFFA726)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_checkout,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
