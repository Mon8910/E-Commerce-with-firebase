import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce_app_with_firebase/constants/constant.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/home/category_round.dart';
import 'package:e_commerce_app_with_firebase/screens/home/last_arrival.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const TitleText(label: 'Shop Smart'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/shopping_cart.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .23,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      AppConstants.imagebanner[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: AppConstants.imagebanner.length,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.red, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: const TitleText(
                  label: 'Last Arrival',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .17,
                  child: ListView.builder(
                    itemCount: productProvider.getProducts.length < 10
                        ? productProvider.getProducts.length
                        : 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Builder(builder: (context) {
                        return ChangeNotifierProvider.value(
                            value: productProvider.getProducts[index],
                            child: LastArrival());
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const TitleText(label: 'Categories'),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: List.generate(
                  AppConstants.categoryList.length,
                  (index) => CategoryRound(
                      name: AppConstants.categoryList[index].name,
                      image: AppConstants.categoryList[index].image),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
