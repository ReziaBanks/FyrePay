import 'package:flutter/material.dart';
import 'package:green_apple_pay/Screens/Splash/app_splash_screen.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Apple Pay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: kWhiteColor,
        appBarTheme: AppBarTheme(
            color: kWhiteColor,
            titleSpacing: 25,
            iconTheme: IconThemeData(
              color: kBlackColor,
            ),
            // brightness: Brightness.dark,
        ),
      ),
      home: AppSplashScreen(),
    );
  }
}
