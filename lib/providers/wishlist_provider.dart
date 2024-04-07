import 'package:e_commerce_app_with_firebase/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WishListProvider extends ChangeNotifier {
  final Map<String, WishListModel> _getWishList = {};
  Map<String, WishListModel> get wishList => _getWishList;
  bool check(String productId) {
    return _getWishList.containsKey(productId);
  }

  void addorRemoveWishList(String productId) {
    if (_getWishList.containsKey(productId)) {
      _getWishList.remove(productId);
    } else {
      _getWishList.putIfAbsent(
        productId,
        () => WishListModel(
          wishId: const Uuid().v4(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeAll() {
    _getWishList.clear();
    notifyListeners();
  }
}
