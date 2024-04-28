import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/cart_empty.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/wishlist_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  final bool isempty = false;

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return wishListProvider.wishList.isEmpty
        ? const Scaffold(
            body: CartEmpty(
            image: 'assets/images/bag_wish.png',
            title: 'Whoops',
            subTitle: 'Your Wishlist is empty',
            details:
                "Looks like you didn't add anything yet to your cart \ngo ahead start shopping now",
            textButton: 'Shop now',
          ))
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: TitleText(
                  label: 'Wishlist(${wishListProvider.wishList.length})'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/shopping_cart.png'),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      MyAppMthods.showErrorWringDialog(
                          isError: false,
                          context: context,
                          fun: () async {
                            await wishListProvider.removeItemFromFirebase();
                          },
                          title: 'Do you want to remove all');
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishListProvider.wishList.length,
              crossAxisCount: 2,
              builder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: wishListProvider.wishList.values.toList()[index],
                  child: ProductWidget(
                    productid: wishListProvider.wishList.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
            ));
  }
}
