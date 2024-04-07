import 'package:flutter/material.dart';

class WishListModel extends ChangeNotifier {
  final String wishId;
  final String productId;

  WishListModel({
    required this.wishId,
    required this.productId,
  });
}
