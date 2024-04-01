import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/cart_empty.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/screens/product/product_widget.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  final bool isempty = false;

  @override
  Widget build(BuildContext context) {
    return isempty
        ? const Scaffold(
            body: CartEmpty(
            image: 'assets/images/shopping_basket.png',
            title: 'Whoops',
            subTitle: 'Your Wishlist is empty',
            details:
                "Looks like you didn't add anything yet to your cart \ngo ahead start shopping now",
            textButton: 'Shop now',
          ))
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const TitleText(label: 'Wishlist(5)'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/shopping_cart.png'),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: 100,
              crossAxisCount: 2,
              builder: (context, index) {
                return const ProductWidget();
              },
            ));
  }
}
