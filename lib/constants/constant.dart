import 'package:e_commerce_app_with_firebase/model/category_round_model.dart';

class AppConstants {
  static const List imagebanner = [
    'assets/images/banner1.png',
    'assets/images/banner2.png'
  ];

  static List<CategoryRoundModel> categoryList = [
    CategoryRoundModel(
      id:'assets/images/book_img.png' ,
      image: 'assets/images/book_img.png',
      name: 'Book',
    ),
    CategoryRoundModel(
      id: 'assets/images/cosmetics.png',
      image: 'assets/images/cosmetics.png',
      name: 'Cosemetics',
    ),
    CategoryRoundModel(
      id: 'assets/images/fashion.png',
      image: 'assets/images/fashion.png',
      name: 'Fashion',
    ),
    CategoryRoundModel(
      id: 'assets/images/mobiles.png',
      image: 'assets/images/mobiles.png',
      name: 'Mobiles',
    ),
    CategoryRoundModel(
      id:'assets/images/pc.png' ,
      image: 'assets/images/pc.png',
      name: 'PC',
    ),
    CategoryRoundModel(
      id: 'assets/images/shoes.png',
      image: 'assets/images/shoes.png',
      name: 'Shoes',
    ),
    CategoryRoundModel(
      id: 'assets/images/watch.png',
      image: 'assets/images/watch.png',
      name: 'Watch',
    ),
    CategoryRoundModel(
      id: 'assets/images/electronics.png',
      image: 'assets/images/electronics.png',
      name: 'Electronics',
    ),
  ];
}
