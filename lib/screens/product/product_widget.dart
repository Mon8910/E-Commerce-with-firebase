import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/heart_button.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/view_recent_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/product/product_detsils_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productid,
  });
  final String productid;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final getProducts = products.getProductModel(productid);
    final cartProduct = Provider.of<CartProvider>(context);
    final viewRecentProvider = Provider.of<ViewRecentProvider>(context);

    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                id: getProducts.productId,
              ),
            ),
          );
          viewRecentProvider.viewRecent(getProducts.productId);
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FancyShimmerImage(
                imageUrl: getProducts!.productImage,
                height: height * .23,
                width: double.infinity,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: TitleText(
                  label: getProducts.productTitle,
                  maxLines: 2,
                )),
                Flexible(
                    child: HeartButtonWidget(
                  productId: getProducts.productId,
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SubtitleText(label: getProducts.productPrice),
                ),
                Flexible(
                  child: IconButton(
                    onPressed: () async {
                      if (cartProduct.checkCartg(getProducts.productId)) {
                        return;
                      }
                      // cartProduct.addCartModel(getProducts.productId);
                      try {
                        await cartProduct.addToCartFireBase(
                            productId: getProducts.productId,
                            quntity: 1,
                            context: context);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        MyAppMthods.showErrorWringDialog(
                          context: context,
                          fun: () {},
                          title: e.toString(),
                        );
                      }
                    },
                    icon: Icon(cartProduct.checkCartg(getProducts.productId)
                        ? Icons.check
                        : Icons.add_shopping_cart_outlined),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
