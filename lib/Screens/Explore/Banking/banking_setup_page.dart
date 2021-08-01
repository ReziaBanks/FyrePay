import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class BankingSetupPage extends StatefulWidget {
  @override
  _BankingSetupPageState createState() => _BankingSetupPageState();
}

class _BankingSetupPageState extends State<BankingSetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackIconButton(),
        title: Text('Banking Setup', style: kAppBarLightTextStyle),
      ),
      body: Center(
        child: Text('Working On Feature', style: TextStyle(
          fontSize: 15,
        ),),
      ),
    );
  }
}
