import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/model/product_model.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  List<ProductModel> productSearch = [];

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    String? productCategorys =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> products = productCategorys == null
        ? product.getProducts
        : product.getNameProduct(productCategorys);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: TitleText(label: productCategorys ?? 'Search'),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/shopping_cart.png'),
            ),
          ),
          body: products.isEmpty
              ? const Center(
                  child: TitleText(label: 'No Product find'),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              textEditingController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            productSearch =
                                product.getSearch(textEditingController.text,products);
                          });
                        },
                        onSubmitted: (value) {},
                      ),
                    ),
                    if (textEditingController.text.isNotEmpty &&
                        productSearch.isEmpty) ...[
                      const Center(
                        child: TitleText(label: 'no prdoct find'),
                      )
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                        itemCount: textEditingController.text.isNotEmpty
                            ? productSearch.length
                            : products.length,
                        crossAxisCount: 2,
                        builder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: products[index],
                              child: ProductWidget(
                                productid: textEditingController.text.isNotEmpty
                                    ? productSearch[index].productId
                                    : products[index].productId,
                              ));
                        },
                      ),
                    )
                  ],
                )),
    );
  }
}
