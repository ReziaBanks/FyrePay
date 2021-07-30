import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_apple_pay/Screens/Auth/create_account_page.dart';
import 'package:green_apple_pay/Screens/Tab/tab_page_new.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';

/// AppSplashScreen
///
/// This dart class loads the app and checks if the a user exist
/// If a user exist, the app will skip the authentication pages
/// If no user is found, the app navigates to the authentication page

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  /// The _stopwatch variable counts the time spent loading the splash screen
  Stopwatch _stopwatch = new Stopwatch();

  @override
  void initState() {
    super.initState();
    /// Call the navigateToNextPage Function
    navigateToNextPage();
  }

  /// Navigation controller function
  ///
  /// 1. This function checks if a user exist
  /// 2. Navigates user to the authentication page (If user doesn't exist)
  /// 3. Skips authentication page and navigates user to home page (If user exist)
  Future<void> navigateToNextPage() async {
    /// _stopwatch variable started
    _stopwatch.start();
    /// Default navigation route
    Widget nextPage = CreateAccount();

    /// Error handler
    try {
      if (!mounted) return;
      /// Checks if user exist and stores it in the currentUser variable
      User? currentUser = FirebaseApi().getCurrentUser();
      if (currentUser != null) {
        /// Updates the default navigation route
        nextPage = NewTabPage();
      }
    } catch (e) {
      print(e);
    }
    /// Retrieve the time elapsed from the stopwatch variable
    ///
    /// The code is built to have minimum possible loading time to 3 seconds
    int timeTakenInSeconds = _stopwatch.elapsed.inSeconds;
    int timeLeft = 3 - timeTakenInSeconds;

    if (!timeLeft.isNegative) {
      Future.delayed(Duration(seconds: timeLeft), () {
        AppFunctions.navigateAndRemove(context, nextPage);
      });
    } else {
      AppFunctions.navigateAndRemove(context, nextPage);
    }
  }

  /// User Interface
  ///
  /// The UI shows the client's logo and a simple text
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Image.asset('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}