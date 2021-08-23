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
  List<AppExploreTileClass> exploreTabs = [
    AppExploreTileClass(
      title: 'Bank Setup',
      page: BankingSetupPage(),
      iconData: Icons.account_balance_wallet,
    ),
    AppExploreTileClass(
      title: 'Donation Settings',
      page: DonationSettingsPage(),
      iconData: Icons.volunteer_activism,
    ),
    AppExploreTileClass(
      title: 'Payment Method',
      page: PaymentMethodPage(),
      iconData: Icons.credit_card,
    ),
    AppExploreTileClass(
      title: 'Transaction History',
      page: TransactionHistoryPage(),
      iconData: Icons.receipt_long,
    ),
    AppExploreTileClass(
      title: 'Donation History',
      page: DonationHistoryPage(),
      iconData: Icons.history,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Explore',
          style: kAppBarHeavyTextStyle,
        ),
        centerTitle: true,
        bottom: AppBasic.appBarBorder(),
      ),
      body: ListView.separated(
        padding: kAppPadding,
        itemCount: exploreTabs.length,
        separatorBuilder: (context, index) => SizedBox(height: 15),
        itemBuilder: (context, index) {
          AppExploreTileClass tileClass = exploreTabs[index];
          return AppExploreCard(tileClass);
        },
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

class AppExploreCard extends StatelessWidget {
  final AppExploreTileClass tileClass;

  AppExploreCard(this.tileClass);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppFunctions.navigate(context, tileClass.page),
      child: Container(
        height: 90,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.0275),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tileClass.title,
              style: TextStyle(
                fontSize: 16,
                color: kGray4DColor,
                letterSpacing: kLetterSpacing,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: kLightPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                tileClass.iconData,
                color: kGray4DColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppExploreTileClass {
  final String title;
  final Widget page;
  final IconData iconData;

  AppExploreTileClass({
    required this.title,
    required this.page,
    required this.iconData,
  });
}
