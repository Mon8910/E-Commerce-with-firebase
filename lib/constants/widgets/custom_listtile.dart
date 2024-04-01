import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomListTile extends StatelessWidget{
  const CustomListTile({super.key, required this.text, required this.image,});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Image.asset(image,height: 30,),
      trailing:const Icon(IconlyLight.arrow_right_2),
    );
  }

}