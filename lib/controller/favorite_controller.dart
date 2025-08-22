import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var favoriteIds = <int>{}.obs; // store recipe ids

  void toggleFavorite(int id) {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
  }

  bool isFavorite(int id) {
    return favoriteIds.contains(id);
  }
}
