import 'package:e_commerce_app_with_firebase/model/cart_model.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _addCart = {};
  Map<String, CartModel> get addCart => _addCart;
  bool checkCartg(String productId) {
    return _addCart.containsKey(productId);
  }

  void addCartModel(String productId) {
    _addCart.putIfAbsent(
      productId,
      () => CartModel(
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  void updateCart(String productId, int quantity) {
    _addCart.update(
      productId,
      (value) => CartModel(
        cartId: value.cartId,
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    _addCart.forEach((key, value) {
      final getTotalProduct = productProvider.getProductModel(value.productId);
      if (getTotalProduct == null) {
        total = 0;
      } else {
        total += double.parse(getTotalProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int totalQuantity() {
    int total = 0;
    _addCart.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void getDelete({required String productId}) {
    _addCart.remove(productId);
    notifyListeners();
  }

  void getRemoveAllCart() {
    _addCart.clear();
    notifyListeners();
  }
}
