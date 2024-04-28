import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/model/cart_model.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/cart/quantity_item.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProviders = Provider.of<CartProvider>(context);
    final getallProducts =
        productProvider.getProductModel(cartProvider.productId);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return getallProducts == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: getallProducts.productImage,
                        width: width * .2,
                        height: height * .2,
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: width * .6,
                                  child: TitleText(
                                    label: getallProducts.productTitle,
                                    maxLines: 2,
                                  )),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await cartProviders
                                          .clearCartFromItemFireBase(
                                        productId: cartProvider.productId,
                                        quntity: cartProvider.quantity,
                                        cartId: cartProvider.cartId,
                                      );
                                      // removeCart.getDelete(productId: cartProvider.productId);
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      IconlyLight.heart,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('${getallProducts.productPrice}\$'),
                              const Spacer(),
                              OutlinedButton.icon(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              topLeft: Radius.circular(30))),
                                      context: context,
                                      builder: (context) {
                                        return QuantityItem(
                                          cartModel: cartProvider,
                                        );
                                      });
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 2, color: Colors.blue
                                      //Theme.of(context).cardColor,
                                      ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                icon: const Icon(IconlyLight.arrow_down_2),
                                label: Text('qty : ${cartProvider.quantity}'),
                              )
                            ],
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
