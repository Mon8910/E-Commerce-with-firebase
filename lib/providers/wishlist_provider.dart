import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/model/wishlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  ////// FireBase

  final usertDB = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  Future<void> addtoWishList(
      {required String productId, required BuildContext context}) async {
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
    final wishId = const Uuid().v4();
    try {
      usertDB.doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            "wishId": wishId,
            "productId": productId,
          },
        ])
      });
      await fetchDtatFromWishListScreen();
      Fluttertoast.showToast(
          msg: "the product is add to WishList",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchDtatFromWishListScreen() async {
    final user = auth.currentUser;
    if (user == null) {
      _getWishList.clear();
      return;
    }
    try {
      final userDoc = await usertDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userWish')) {
        return;
      }
      final leng = userDoc.get('userWish').length;
      for (int index = 0; index < leng; index++) {
        _getWishList.putIfAbsent(
            userDoc.get('userWish')[index]['productId'],
            () => WishListModel(
                  wishId: userDoc.get('userWish')[index]['wishId'],
                  productId: userDoc.get('userWish')[index]['productId'],
                ));
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItemFromFirebase() async {
    User? user = auth.currentUser;
    try {
      await usertDB.doc(user!.uid).update({'userWish': []});
      _getWishList.clear();
      // await fetchDataFromFirebase();
      
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
  // await usersDB.doc(user!.uid).update({"userWish": []});
  //   _wishlistItems.clear();

  Future<void> clearCartFromItemFireBase(
      {required String productId, required String wishId}) async {
    User? user = auth.currentUser;
    try {
      await usertDB.doc(user!.uid).update({
        'userWish': FieldValue.arrayRemove([
          {
            "wishId": wishId,
            "productId": productId,
          },
        ])
      });
      _getWishList.remove(productId);
      await fetchDtatFromWishListScreen();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
