import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/model/cart_model.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _addCart = {};
  Map<String, CartModel> get addCart => _addCart;
  bool checkCartg(String productId) {
    return _addCart.containsKey(productId);
  }

//firebase
  final usertDB = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  Future<void> addToCartFireBase(
      {required String productId,
      required int quntity,
      required BuildContext context}) async {
    final user = auth.currentUser;
    if (user == null) {
      MyAppMthods.showErrorWringDialog(
        context: context,
        fun: () {},
        title: 'No user found',
      );
      return;
    }
    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      usertDB.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            "cartId": cartId,
            "productId": productId,
            "quntity": quntity,
          },
        ])
      });
      await fetchDataFromFirebase();
      Fluttertoast.showToast(
          msg: "the product is add to cart",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchDataFromFirebase() async {
    final user = auth.currentUser;
    if (user == null) {
      _addCart.clear();
      return;
    }
    try {
      final userDoc = await usertDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userCart')) {
        return;
      }
      final leng = userDoc.get('userCart').length;
      for (int index = 0; index < leng; index++) {
        _addCart.putIfAbsent(
            userDoc.get('userCart')[index]['productId'],
            () => CartModel(
                  cartId: userDoc.get('userCart')[index]['cartId'],
                  productId: userDoc.get('userCart')[index]['productId'],
                  quantity: userDoc.get('userCart')[index]['quntity'],
                ));
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
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

  Future<void> removeItemFromFirebase() async {
    User? user = auth.currentUser;
    try {
      await usertDB.doc(user!.uid).update({'userCart': []});
      _addCart.clear();
      // await fetchDataFromFirebase();
       notifyListeners();

    } catch (e) {
      rethrow;
    }
   
  }

  Future<void> clearCartFromItemFireBase(
      {required String productId,
      required int quntity,
      required String cartId}) async {
    User? user = auth.currentUser;
    try {
      await usertDB.doc(user!.uid).update({
        'userCart': FieldValue.arrayRemove([
          {
            "cartId": cartId,
            "productId": productId,
            "quntity": quntity,
          },
          
        ])

      });
      _addCart.remove(productId);
      await fetchDataFromFirebase();
    } catch (e) {
      rethrow;
    }
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
