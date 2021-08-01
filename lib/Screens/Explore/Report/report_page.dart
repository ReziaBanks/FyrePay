import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Explore/Report/transaction_history_page.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

import 'donation_history_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports', style: kAppBarHeavyTextStyle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppBoxCard(
                title: 'Transaction History',
                onPressed: () {
                  AppFunctions.navigate(context, TransactionHistoryPage());
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: AppBoxCard(
                title: 'Donation History',
                onPressed: () {
                  AppFunctions.navigate(context, DonationHistoryPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
