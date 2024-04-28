import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  final String userId;
  final String userName;
  final String userImage;
  final String userEmail;
  final Timestamp createdAt;
  final List userCart;
  final List userWish;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.createdAt,
    required this.userCart,
    required this.userWish,
  });
}
