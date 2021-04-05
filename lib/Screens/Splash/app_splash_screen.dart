import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_apple_pay/Screens/Auth/create_account_page.dart';
import 'package:green_apple_pay/Screens/Tab/tab_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  Stopwatch _stopwatch = new Stopwatch();

  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  Future<void> navigateToNextPage() async {
    _stopwatch.start();
    Widget nextPage = CreateAccount();
    try {
      if (!mounted) return;
      User currentUser = FirebaseApi().getCurrentUser();
      if (currentUser != null) {
        nextPage = TabPage();
      }
    } catch (e) {
      print(e);
    }
    int timeTakenInSeconds = _stopwatch.elapsed.inSeconds;
    int timeLeft = 3 - timeTakenInSeconds;

    if (!timeLeft.isNegative) {
      Future.delayed(Duration(seconds: timeLeft), () {
        navigate(nextPage);
      });
    } else {
      navigate(nextPage);
    }
  }

  void navigate(Widget page) {
    AppFunctions.navigateAndRemove(context, page);
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Image.asset('assets/logo.png'),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              child: Text(
                'By Mohawk Devs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: kBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}