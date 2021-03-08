import 'package:flutter/material.dart';
import 'package:green_apple_pay/Screens/Home/tab_page.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:splashscreen/splashscreen.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: TabPage(),
      title: Text(
        'Green Apple Pay',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: kWhiteColor,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      loaderColor: kWhiteColor,
    );
  }
}
