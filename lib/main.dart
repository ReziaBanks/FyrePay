import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Screens/Splash/app_splash_screen.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:provider/provider.dart';
import 'Utility/Providers/app_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Green Apple',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
          scaffoldBackgroundColor: kWhiteColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: kWhiteColor,
            titleSpacing: kHorizontalPaddingValue,
            iconTheme: IconThemeData(
              color: kBlackColor,
            ),
          ),
        ),
        home: AppSplashScreen(),
      ),
    );
  }
}
