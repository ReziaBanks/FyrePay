import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class AccountSecurityPage extends StatefulWidget {
  @override
  _AccountSecurityPageState createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Security', style: kAppBarLightTextStyle),
      ),
      body: ListView(
        padding: kAppPadding,
        physics: ClampingScrollPhysics(),
        children: [
          //Current Password
          AppTextField(
            hintText: 'Enter Current Password',
            controller: _currentPasswordController,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          //New Password
          AppTextField(
            hintText: 'Enter New Password',
            controller: _passwordController,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          //Repeat New Password
          AppTextField(
            hintText: 'Repeat New Password',
            controller: _repeatPasswordController,
            textInputAction: TextInputAction.go,
          ),
          SizedBox(height: 15),
          //Confirm button
          AppButton(
            title: "Update Now",
            onPressed: () {
              //Hash & send password change request
            },
          )
        ],
      ),
    );
  }
}
