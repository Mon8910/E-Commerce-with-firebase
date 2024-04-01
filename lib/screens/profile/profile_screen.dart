import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/app_name_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/custom_listtile.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:e_commerce_app_with_firebase/providers/theme_provider.dart';
import 'package:e_commerce_app_with_firebase/screens/profile/order_scrren.dart';
import 'package:e_commerce_app_with_firebase/screens/profile/view_recent_screen.dart';
import 'package:e_commerce_app_with_firebase/screens/profile/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const AppNameText(),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/shopping_cart.png'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child:
                      TitleText(label: 'Please Login to have ultimate access'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.background,
                              width: 3)),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(label: 'ayman mohamed'),
                      SizedBox(
                        height: 4,
                      ),
                      SubtitleText(
                        label: 'aymanmo493@gmail.com',
                        fontSize: 14,
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(label: 'General'),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const OrderScreen(),
                          ),
                        );
                      },
                      child: const CustomListTile(
                          text: 'Order', image: 'assets/images/order_svg.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WishListScreen()));
                      },
                      child: const CustomListTile(
                          text: 'Wishlist',
                          image: 'assets/images/wishlist_svg.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewRecentScreen()));
                      },
                      child: const CustomListTile(
                          text: 'Viewed recent',
                          image: 'assets/images/recent.png'),
                    ),
                    const CustomListTile(
                        text: 'Address', image: 'assets/images/address.png'),
                    const Divider(
                      thickness: 2,
                    ),
                    const TitleText(label: 'Setting'),
                    SwitchListTile(
                      secondary: Image.asset(
                        'assets/images/theme.png',
                        height: 30,
                      ),
                      value: themeProvider.getIsDarkThmeme,
                      onChanged: (val) {
                        themeProvider.setIsDarkTheme(val);
                      },
                      title: themeProvider.getIsDarkThmeme
                          ? const Text('Dark Mode')
                          : const Text('Light Mode'),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          MyAppMthods.showErrorWringDialog(
                              context: context,
                              fun: () {},
                              title: 'Are you sure? ');
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.red),
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
