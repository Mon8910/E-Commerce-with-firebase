import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/cart_empty.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/cart/bottom_checkout.dart';
import 'package:e_commerce_app_with_firebase/screens/cart/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isempty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.addCart.isEmpty
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
              title: TitleText(label: 'Cart(${cartProvider.addCart.length})'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/shopping_cart.png'),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      MyAppMthods.showErrorWringDialog(context: context, fun: (){
                        cartProvider.getRemoveAllCart();
                      }, title: 'Do. you want to clear cart');
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            body: Column(children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cartProvider.addCart.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: cartProvider.addCart.values
                              .toList()
                              .reversed
                              .toList()[index],
                          child: const CartWidget());
                    }),
              ),
              const SizedBox(
                height: kBottomNavigationBarHeight + 10,
              )
            ]),
          );
  }
}
