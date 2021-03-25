import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Screens/Auth/create_account_page.dart';
import 'package:green_apple_pay/Screens/Home/tab_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:splashscreen/splashscreen.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {

  Future<Widget> navigateTo() async{
    await Future.delayed(Duration(seconds: 3), (){
      print('Done');
    });
    User user = FirebaseApi().getCurrentUser();
    if(user != null){
      return TabPage();
    }
    else{
      return CreateAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterFuture: navigateTo(),
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
