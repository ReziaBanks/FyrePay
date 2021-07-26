import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Banking/banking_setup_page.dart';
import 'package:green_apple_pay/Screens/Banking/payment_method_page.dart';
import 'package:green_apple_pay/Screens/Settings/donation_settings_page.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class BankingPage extends StatefulWidget {
  @override
  _BankingPageState createState() => _BankingPageState();
}

class _BankingPageState extends State<BankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banking', style: kAppBarHeavyTextStyle,),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppBoxCard(
                title: 'Banking Setup',
                onPressed: () {
                  AppFunctions.navigate(context, BankingSetupPage());
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: AppBoxCard(
                title: 'Donation Settings',
                onPressed: () {
                  AppFunctions.navigate(context, DonationSettingsPage());
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: AppBoxCard(
                title: 'Payment Method',
                onPressed: () {
                  AppFunctions.navigate(context, PaymentMethodPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
