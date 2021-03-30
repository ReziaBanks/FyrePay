import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class ManageOrganizationPage extends StatefulWidget {
  @override
  _ManageOrganizationPageState createState() => _ManageOrganizationPageState();
}

class _ManageOrganizationPageState extends State<ManageOrganizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Organization', style: kAppBarLightTextStyle,),
      ),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}
