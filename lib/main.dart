import 'package:e_commerce_app_with_firebase/constants/theme_data.dart';
import 'package:e_commerce_app_with_firebase/providers/theme_provider.dart';
import 'package:e_commerce_app_with_firebase/root_screen.dart';
import 'package:e_commerce_app_with_firebase/screens/auth/login_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context,val,child) {
          return MaterialApp(
              theme: Styles.themeData(isDarkTheme: val.getIsDarkThmeme, context: context),
              home: const LoginScreen());
        }
      ),
    );
  }
}
