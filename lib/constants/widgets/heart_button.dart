import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.size = 22,
    this.color = Colors.transparent,
    required this.productId,
  });
  final double size;
  final Color color;
  final String productId;
  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
        ),
        onPressed: () async {
          // wishListProvider.addorRemoveWishList(widget.productId);
          setState(() {
            isLoading = true;
          });
          try {
            if (wishListProvider.wishList.containsKey(widget.productId)) {
              wishListProvider.clearCartFromItemFireBase(
                productId: widget.productId,
                wishId: wishListProvider.wishList[widget.productId]!.wishId,
              );
            } else {
              wishListProvider.addtoWishList(
                  productId: widget.productId, context: context);
            }
            await wishListProvider.fetchDtatFromWishListScreen();
          } catch (e) {
            // ignore: use_build_context_synchronously
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
        },
        icon: isLoading
            ? const CircularProgressIndicator()
            : Icon(
                wishListProvider.check(widget.productId)
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                size: widget.size,
                color: Colors.red,
              ),
      ),
    );
  }
}
