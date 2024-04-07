import 'package:e_commerce_app_with_firebase/model/view_recently_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewRecentProvider extends ChangeNotifier {
  final Map<String, ViewRecentlyModel> _getViewRecent = {};
  Map<String, ViewRecentlyModel> get getViewRecent => _getViewRecent;
  bool check(String productId) {
    return _getViewRecent.containsKey(productId);
  }

  void viewRecent(String productId) {
    _getViewRecent.putIfAbsent(
      productId,
      () => ViewRecentlyModel(
        viewRecentId: const Uuid().v4(),
        productId: productId,
      ),
    );

    notifyListeners();
  }
}
