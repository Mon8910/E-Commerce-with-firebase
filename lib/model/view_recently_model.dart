import 'package:flutter/material.dart';

class ViewRecentlyModel extends ChangeNotifier {
  final String viewRecentId;
  final String productId;

  ViewRecentlyModel({
    required this.viewRecentId,
    required this.productId,
  });
}
