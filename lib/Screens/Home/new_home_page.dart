import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Banking/banking_setup_page.dart';
import 'package:green_apple_pay/Screens/Donations/all_donations_page.dart';
import 'package:green_apple_pay/Screens/Settings/donation_settings_page.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:line_icons/line_icons.dart';

class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Green Apple',
          style: kAppBarHeavyTextStyle,
        ),
        centerTitle: true,
        bottom: AppBasic.appBarBorder(),
        actions: [
          IconButton(
            icon: Icon(LineIcons.receipt),
            onPressed: () {
              AppFunctions.navigate(context, AllDonationsPage());
            },
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.settings),),
        ],
      ),
      body: ListView(
        padding: kAppPadding,
        children: [
          AppCard(
            title: 'Total Donated',
          ),
          SizedBox(height: 15),
          AppCard(
            title: 'Last Month',
          ),
          SizedBox(height: 15),
          AppCard(
            title: 'This Month',
          ),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFDFE5E8),
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  color: kLightPrimaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Things To Do',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '2 Of 4',
                        style: TextStyle(
                          color: kGray4DColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFDFE5E8),
                ),
                AppCheckListTile(
                  title: 'Select Organizations To Support',
                  isChecked: true,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFDFE5E8),
                  height: 1,
                ),
                AppCheckListTile(
                  title: 'Connect Bank Account',
                  isChecked: false,
                  onPressed: () {
                    AppFunctions.navigate(context, BankingSetupPage());
                  },
                ),
                Divider(
                  thickness: 1,
                  height: 1,
                  color: Color(0xFFDFE5E8),
                ),
                AppCheckListTile(
                  title: 'Set Up Donations',
                  isChecked: false,
                  onPressed: () {
                    AppFunctions.navigate(context, DonationSettingsPage());
                  },
                ),
                Divider(
                  thickness: 1,
                  height: 1,
                  color: Color(0xFFDFE5E8),
                ),
                AppCheckListTile(
                  title: 'Choose Billing Account',
                  isChecked: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppCheckListTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final Function()? onPressed;

  AppCheckListTile({
    required this.title,
    required this.isChecked,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            Icon(
              isChecked ? LineIcons.check : LineIcons.arrowRight,
              size: 20,
              color: isChecked ? Color(0xFF4ABB92) : kPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  AppCard({
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: Color(0xFFDFE5E8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            '\$40.36',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

