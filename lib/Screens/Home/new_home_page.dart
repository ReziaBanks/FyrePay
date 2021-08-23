import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Components/Metric/metric_components.dart';
import 'package:green_apple_pay/Screens/Explore/Banking/banking_setup_page.dart';
import 'package:green_apple_pay/Screens/Explore/Banking/payment_method_page.dart';
import 'package:green_apple_pay/Screens/Organization/manage_organization_page.dart';
import 'package:green_apple_pay/Screens/Settings/donation_settings_page.dart';
import 'package:green_apple_pay/Screens/Settings/settings_page.dart';
import 'package:green_apple_pay/Utility/Classes/Metric/metric_class.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:line_icons/line_icons.dart';

class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  List<AppMetric> metricList = AppData.metricList;

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
            icon: Icon(Icons.settings),
            onPressed: () => AppFunctions.navigate(context, SettingsPage()),
          ),
        ],
      ),
      body: ListView(
        padding: kAppPadding,
        physics: ClampingScrollPhysics(),
        children: [
          ListView.separated(
            itemCount: metricList.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 17),
            itemBuilder: (context, index) {
              AppMetric metric = metricList[index];
              return AppMetricCard(metric, onPressed: () {});
            },
          ),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFDFE5E8),
                width: 0.75,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  color: Color(0xFFf4f8fc),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Things To Do',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: kLetterSpacing,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '2 Of 4',
                        style: TextStyle(
                          color: kGray4DColor,
                          letterSpacing: kLetterSpacing,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                AppDivider(),
                AppCheckListTile(
                  title: 'Select Organizations To Support',
                  isChecked: true,
                  onPressed: () => AppFunctions.navigate(context, ManageOrganizationPage()),
                ),
                AppDivider(),
                AppCheckListTile(
                  title: 'Connect Bank Account',
                  isChecked: false,
                  onPressed: () => AppFunctions.navigate(context, BankingSetupPage()),
                ),
                AppDivider(),
                AppCheckListTile(
                  title: 'Set Up Donations',
                  isChecked: false,
                  onPressed: () =>
                    AppFunctions.navigate(context, DonationSettingsPage()),
                ),
                AppDivider(),
                AppCheckListTile(
                  title: 'Choose Billing Account',
                  isChecked: true,
                  onPressed: () => AppFunctions.navigate(context, PaymentMethodPage()),
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
    return Material(
      color: kWhiteColor,
      child: InkWell(
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
                  letterSpacing: kLetterSpacing,
                  color: isChecked ? kGray4DColor : kBlackColor,
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
      ),
    );
  }
}
