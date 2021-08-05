import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Explore/Banking/banking_setup_page.dart';
import 'package:green_apple_pay/Screens/Explore/Banking/payment_method_page.dart';
import 'package:green_apple_pay/Screens/Explore/Report/donation_history_page.dart';
import 'package:green_apple_pay/Screens/Explore/Report/transaction_history_page.dart';
import 'package:green_apple_pay/Screens/Settings/donation_settings_page.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:line_icons/line_icons.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Explore', style: kAppBarHeavyTextStyle,),
        centerTitle: true,
        bottom: AppBasic.appBarBorder(),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          AppExploreTile(
            title: 'Bank Setup',
            subTitle: 'It is a long established fact',
            onPressed: ()=> AppFunctions.navigate(context, BankingSetupPage()),
          ),
          AppDivider(),
          AppExploreTile(
            title: 'Donation Settings',
            subTitle: 'There are many variations',
            onPressed: ()=> AppFunctions.navigate(context, DonationSettingsPage()),
          ),
          AppDivider(),
          AppExploreTile(
            title: 'Payment Method',
            subTitle: 'Lorem Ipsum is not simply random text.',
            onPressed: ()=> AppFunctions.navigate(context, PaymentMethodPage()),
          ),
          AppDivider(),
          AppExploreTile(
            title: 'Transaction History',
            subTitle: 'All the Lorem Ipsum generators',
            onPressed: ()=> AppFunctions.navigate(context, TransactionHistoryPage()),
          ),
          AppDivider(),
          AppExploreTile(
            title: 'Donation History',
            subTitle: 'The standard chunk of Lorem Ipsum',
            onPressed: ()=> AppFunctions.navigate(context, DonationHistoryPage()),
          ),
          AppDivider(),
        ],
      ),
    );
  }
}

class AppExploreTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function()? onPressed;

  AppExploreTile({
    required this.title,
    required this.subTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: kLetterSpacing,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: kGray4DColor,
                      letterSpacing: kLetterSpacing,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Icon(LineIcons.angleRight, size: 20),
          ],
        ),
      ),
    );
  }
}
