import 'package:e_commerce_app_with_firebase/constants/widgets/cart_empty.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/screens/cart/bottom_checkout.dart';
import 'package:e_commerce_app_with_firebase/screens/cart/cart_widget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isempty = false;

  @override
  Widget build(BuildContext context) {
    return isempty
        ? const Scaffold(
            body: CartEmpty(
            image: 'assets/images/shopping_basket.png',
            title: 'Whoops',
            subTitle: 'Your Cart is empty',
            details:
                "Looks like you didn't add anything yet to your cart \ngo ahead start shopping now",
            textButton: 'Shop now',
          ))
        : Scaffold(
            bottomSheet: const BottomCheckout(),
            appBar: AppBar(
              elevation: 0.0,
              title: const TitleText(label: 'Cart(5)'),
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
            body: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const CartWidget();
                }),
          );
  }
}
