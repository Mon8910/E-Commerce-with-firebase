
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId;
  final String productPrice;
  final String productTitle;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String productQuantity;

  ProductModel({
    required this.productId,
    required this.productPrice,
    required this.productTitle,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
  });
  
}
