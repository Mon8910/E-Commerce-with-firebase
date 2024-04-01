import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/screens/product/product_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const TitleText(label: 'Search'),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/shopping_cart.png'),
            ),
          ),
          body: Column(
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
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                ),
              ),
              Expanded(
                child: DynamicHeightGridView(
                  itemCount: 100,
                  crossAxisCount: 2,
                  builder: (context, index) {
                    return const ProductWidget();
                  },
                ),
              )
            ],
          )),
    );
  }
}
