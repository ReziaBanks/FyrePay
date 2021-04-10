import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Screens/Splash/app_splash_screen.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:provider/provider.dart';
import 'Utility/Providers/app_provider.dart';

/// Main.dart
///
/// This class is the starting block of the entire project

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Provider for state management
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
