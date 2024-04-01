import 'package:e_commerce_app_with_firebase/screens/cart/cart_screen.dart';
import 'package:e_commerce_app_with_firebase/screens/home/home_screen.dart';
import 'package:e_commerce_app_with_firebase/screens/profile/profile_screen.dart';
import 'package:e_commerce_app_with_firebase/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() {
    return _RootScreen();
  }
}

class _RootScreen extends State<RootScreen> {
  PageController? controller;
  int currentScreen = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  void initState() {
    controller = PageController(
      initialPage: currentScreen,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        onDestinationSelected: (value) {
          setState(() {
            currentScreen = value;
            controller!.jumpToPage(currentScreen);
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(IconlyLight.home),
              selectedIcon: Icon(IconlyBold.home),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(IconlyLight.search),
              selectedIcon: Icon(IconlyBold.search),
              label: 'Search'),
          NavigationDestination(
              icon: Badge(label: Text('5'),child: Icon(IconlyLight.bag_2)),
              selectedIcon: Icon(IconlyBold.bag_2),
              label: 'Cart'),
          NavigationDestination(
              icon: Icon(IconlyLight.profile),
              selectedIcon: Icon(IconlyBold.profile),
              label: 'Profile')
        ],
      ),
    );
  }
}
