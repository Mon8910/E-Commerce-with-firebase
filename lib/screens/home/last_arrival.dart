import 'package:e_commerce_app_with_firebase/constants/widgets/heart_button.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/model/product_model.dart';
import 'package:e_commerce_app_with_firebase/providers/view_recent_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/product/product_detsils_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LastArrival extends StatelessWidget {
  const LastArrival({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductModel>(context);
    final viewRecentProvider = Provider.of<ViewRecentProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: size.width * .45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsScreen(id: productProvider.productId),
                ),
              );
              viewRecentProvider.viewRecent(productProvider.productId);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: FancyShimmerImage(
                    imageUrl: productProvider.productImage,
                    width: size.width * .28,
                    height: size.height * .28,
                    // boxFit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        label: productProvider.productTitle,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            HeartButtonWidget(
                              productId: productProvider.productId,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_shopping_cart_sharp),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Flexible(
                        child: SubtitleText(
                            label: '${productProvider.productPrice}\$'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
