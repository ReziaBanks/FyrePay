import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Auth/login_to_account_page.dart';
import 'package:green_apple_pay/Screens/Settings/account_details_page.dart';
import 'package:green_apple_pay/Screens/Settings/account_security_page.dart';
import 'package:green_apple_pay/Screens/Settings/bank_account_info_page.dart';
import 'package:green_apple_pay/Screens/Settings/donation_settings_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextStyle _basicStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  void logout() async{
    AppFunctions.navigateAndRemove(context, LoginToAccount());
    await FirebaseApi().logOutUser();
  }

  void launchUrl(String url) {
    try {
      AppFunctions.launchUrl(url);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: kAppBarHeavyTextStyle),
        centerTitle: false,
      ),
      body: ListView(
        padding: kAppPadding,
        children: [
          //Account Details
          Text(
            'Account Details',
            style: _basicStyle,
          ),
          SizedBox(height: 15),

          AppContentTile(
            title: 'Change Email',
            onPressed: () {
              AppFunctions.navigate(context, AccountDetailsPage());
            },
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Security',
            onPressed: () {
              AppFunctions.navigate(context, AccountSecurityPage());
            },
          ),
          SizedBox(height: 35),

          //Connection
          Text(
            'Connection',
            style: _basicStyle,
          ),
          SizedBox(height: 15),

          AppContentTile(
            title: 'Bank Account Info',
            onPressed: (){
              AppFunctions.navigate(context, BankAccountInfoPage());
            },
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Donation Settings',
            onPressed: () {
              AppFunctions.navigate(context, DonationSettingsPage());
            },
          ),
          //About
          SizedBox(height: 35),
          Text(
            'About Green Apple Pay',
            style: _basicStyle,
          ),
          SizedBox(height: 15),

          AppContentTile(
            title: 'Privacy Policy',
            onPressed: () {
              launchUrl('${AppData.defaultUrl}');
            },
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Terms Of Service',
            onPressed: () {
              launchUrl('${AppData.defaultUrl}');
            },
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Logout',
            titleColor: Color.fromARGB(150, 255, 0, 0),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
    );
  }
}
