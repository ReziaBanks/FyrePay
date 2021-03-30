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
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){}, color: kPrimaryColor,),
        ],
      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
