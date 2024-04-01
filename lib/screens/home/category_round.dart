import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class CategoryRound extends StatelessWidget {
  const CategoryRound({
    super.key,
    required this.name,
    required this.image,
  });
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 15,),
        SubtitleText(
          label: name,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
