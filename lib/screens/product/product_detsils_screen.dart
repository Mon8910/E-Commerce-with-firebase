import 'package:e_commerce_app_with_firebase/constants/widgets/heart_button.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final getProducts = products.getProductModel(id);
    Size size = MediaQuery.of(context).size;
    final cartProduct = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const TitleText(label: 'Shop Smart'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: getProducts!.productImage,
              height: size.height * .35,
              width: double.infinity,
              boxFit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          getProducts.productTitle,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: SubtitleText(
                          label: getProducts.productPrice,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                     HeartButtonWidget(productId: getProducts.productId,),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            cartProduct.addCartModel(getProducts.productId);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.lightBlue),
                          icon: Icon(
                              cartProduct.checkCartg(getProducts.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined),
                          label: Text(
                              cartProduct.checkCartg(getProducts.productId)
                                  ? ' Added in Cart'
                                  : ' Add to cart'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(label: 'About this item'),
                      TitleText(label: 'In Phones'),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SubtitleText(label: getProducts.productDescription)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
