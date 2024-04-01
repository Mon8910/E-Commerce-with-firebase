import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class LastArrival extends StatelessWidget {
  const LastArrival({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: size.width*.45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: FancyShimmerImage(
                  imageUrl: 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
                  width: size.width * .28,
                  height: size.height * .28,
                 // boxFit: BoxFit.fill,
                ),
              ),
            const  SizedBox(width: 7,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const  TitleText(
                      label: 'texadcasdadsvasdvasdvadsfvcasdvt' ,
                      maxLines: 1,
                      
                    ),
                    SizedBox(height: 10,),
                    FittedBox(
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(IconlyLight.heart),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_shopping_cart_sharp),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                  Flexible(
                    child: SubtitleText(label: '120\$'),
                  )
                  ],
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
