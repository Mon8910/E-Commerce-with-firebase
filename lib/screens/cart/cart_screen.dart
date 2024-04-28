import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/cart_empty.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/user_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/cart/bottom_checkout.dart';
import 'package:e_commerce_app_with_firebase/screens/cart/cart_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final bool isempty = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
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
            bottomSheet: BottomCheckout(
              function: () async {
               await placeOreder(
                  cartProvider: cartProvider,
                  productProvider: productProvider,
                  userProvider: userProvider,
                );
              },
            ),
            appBar: AppBar(
              elevation: 0.0,
              title: TitleText(label: 'Cart(${cartProvider.addCart.length})'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/shopping_cart.png'),
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      MyAppMthods.showErrorWringDialog(
                          context: context,
                          fun: () async {
                            await cartProvider.removeItemFromFirebase();
                          },
                          title: 'Do. you want to clear cart');
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

  Future<void> placeOreder({
    required CartProvider cartProvider,
    required ProductProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;
    try {
      setState(() {
        isLoading = true;
      });
      cartProvider.addCart.forEach((key, value) async {
        final getProducts = productProvider.getProductModel(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance.collection('order').doc(orderId).set({
          'orderId': orderId,
          'userId': userId,
          'productId': value.productId,
          'productTitle': getProducts!.productTitle,
          'userNmae': userProvider.userModel!.userName,
          'price': double.parse(getProducts.productPrice) * value.quantity,
          'image': getProducts.productImage,
          'totalPrice': cartProvider.getTotal(productProvider: productProvider),
          'quantity': value.quantity,
          'orderDates': Timestamp.now()
        });
        await cartProvider.removeItemFromFirebase();
        cartProvider.getRemoveAllCart();
      });
    } catch (e) {
      MyAppMthods.showErrorWringDialog(
        context: context,
        fun: () {},
        title: e.toString(),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
