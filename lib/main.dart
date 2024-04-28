import 'package:e_commerce_app_with_firebase/constants/theme_data.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/order_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/product_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/theme_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/user_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/view_recent_provider.dart';
import 'package:e_commerce_app_with_firebase/providers/wishlist_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/auth/login_auth.dart';
import 'package:e_commerce_app_with_firebase/screens/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewRecentProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
        
      ],
      child: Consumer<ThemeProvider>(builder: (context, val, child) {
        return MaterialApp(
          theme: Styles.themeData(
              isDarkTheme: val.getIsDarkThmeme, context: context),
          home: const LoginScreen(),
          routes: {'searchname': (context) => const SearchScreen()},
        );
      }),
    );
  }
}
