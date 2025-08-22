import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartItem {
  final int id;
  final String name;
  final String image;
  int quantity;
  final int servings;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.servings,
    required this.price,
  });
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(CartItem item) {
    final index = cartItems.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      Get.snackbar(
        "Already in Cart",
        "${item.name} is already added",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFA726),
        colorText: const Color(0xFFFFFFFF),
      );
    } else {
      cartItems.add(item);
      Get.snackbar(
        "Added",
        "${item.name} added to cart",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffFC6011),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  void increment(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decrement(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
    cartItems.refresh();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  void removeFromCart(int id) {
    cartItems.removeWhere((item) => item.id == id);
  }
}
