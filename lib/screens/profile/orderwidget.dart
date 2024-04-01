import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class OrdersWidgetFree extends StatelessWidget {
  const OrdersWidgetFree({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FancyShimmerImage(
            imageUrl: 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
            width: size.width * .2,
            height: size.height * .15,
            boxFit: BoxFit.fill,
          ),
          Flexible(
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      Flexible(child: TitleText(label: 'Product title' *10,
                      maxLines: 2,)),
                      
                       const Icon(Icons.clear)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SubtitleText(label: 'price: 123\$'),
                  const SizedBox(
                    height: 10,
                  ),
                  const SubtitleText(label: 'qty :4'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
