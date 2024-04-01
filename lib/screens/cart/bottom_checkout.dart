import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:flutter/material.dart';

class BottomCheckout extends StatelessWidget {
  const BottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight + 0,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: TitleText(
                      label: "Total (6 products/6 items)",
                      fontSize: 14,
                    )),
                    SubtitleText(
                      label: '123\$',
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(onPressed: () {}, child: const Text('Check out'))
            ],
          ),
        ),
      ),
    );
  }
}
