import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel => userModel;
  Future<UserModel?> fetchUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    try {
      var uid = user.uid;
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userDocData = userDoc.data();
      userModel = UserModel(
        userId: userDoc.get('userId'),
        userName: userDoc.get('userName'),
        userImage: userDoc.get('userImage'),
        userEmail: userDoc.get('userEmail'),
        createdAt: userDoc.get('createdAt'),
        userCart:
            userDocData!.containsKey('userCart') ? userDoc.get('userCart') : [],
        userWish:
            userDocData.containsKey('userWish') ? userDoc.get('userWish') : [],
      );
      return userModel;
    } on FirebaseException catch (error) {
      throw error.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
