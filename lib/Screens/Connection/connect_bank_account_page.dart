import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Tab/tab_page.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';

/// A page that represents the design of the process of the user connecting their bank account
/// with FyrePay services.
///
/// Page is filled with Lorem ipsum text from Misc -> data.dart variables
///
/// Theoretically connects bank account with card information.

class ConnectBankAccountPage extends StatefulWidget {
  @override
  _ConnectBankAccountPageState createState() => _ConnectBankAccountPageState();
}

class _ConnectBankAccountPageState extends State<ConnectBankAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Connection', style: kAppBarLightTextStyle),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            AppFunctions.navigateAndRemove(context, TabPage());
          },
        ),
      ),
      body: Padding(
        padding: kAppPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${AppData.bankConnectionText}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: kGray4DColor,
                height: 150 / 100,
              ),
            ),
            Image.asset('assets/bank.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppButton(
                  title: 'Connect Now',
                  onPressed: () {
                    AppFunctions.navigateAndRemove(context, TabPage());
                  },
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    AppFunctions.navigateAndRemove(context, TabPage());
                  },
                  child: Text(
                    'Skip and connect later',
                    style: TextStyle(
                      fontSize: 16,
                      color: kGray4DColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
