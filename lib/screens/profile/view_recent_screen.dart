import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/cart_empty.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/view_recent_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewRecentScreen extends StatelessWidget {
  const ViewRecentScreen({super.key});
  final bool isempty = false;

  @override
  Widget build(BuildContext context) {
    final viewRecentProvider = Provider.of<ViewRecentProvider>(context);

    return isempty
        ? const Scaffold(
            body: CartEmpty(
            image: 'assets/images/shopping_basket.png',
            title: 'Whoops',
            subTitle: 'Your Viewed Recent is empty',
            details:
                "Looks like you didn't add anything yet to your cart \ngo ahead start shopping now",
            textButton: 'Shop now',
          ))
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const TitleText(label: 'View Recent(5)'),
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
              itemCount: viewRecentProvider.getViewRecent.length,
              crossAxisCount: 2,
              builder: (context, index) {
                return ChangeNotifierProvider.value(
                    value:
                        viewRecentProvider.getViewRecent.values.toList()[index],
                    child: ProductWidget(
                      productid: viewRecentProvider.getViewRecent.values
                          .toList()[index]
                          .productId,
                    ));
              },
            ));
  }
}
