import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomCheckout extends StatelessWidget {
  const BottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return SizedBox(
      height: kBottomNavigationBarHeight + 10,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: TitleText(
                      label:
                          "Total (${cartProvider.addCart.length} products/${cartProvider.totalQuantity()} items)",
                      fontSize: 14,
                    )),
                    FittedBox(
                      child: SubtitleText(
                        label:
                            '${cartProvider.getTotal(productProvider: productProvider)}\$',
                        color: Colors.blue,
                      ),
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
