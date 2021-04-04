import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class BankAccountInfoPage extends StatefulWidget {
  @override
  _BankAccountInfoPageState createState() => _BankAccountInfoPageState();
}

class _BankAccountInfoPageState extends State<BankAccountInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Account Info', style: kAppBarLightTextStyle),
      ),
      body: Center(
        child: Text('Feature Not Supported'),
      ),
    );
  }
}
