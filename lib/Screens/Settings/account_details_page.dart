import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  TextEditingController _newEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details', style: kAppBarLightTextStyle),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: kAppPadding,
        children: [
          //Current Email
          AppContentTile(
            title: 'Current Email',
            height: 55,
            trailingWidget: Text(
              'example@email.com',
              style: TextStyle(
                fontSize: 15,
                color: kGray85Color,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: 15),
          AppTextField(
            hintText: 'Enter Current Password',
            controller: _passwordController,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          //New Password
          AppTextField(
            hintText: 'Enter New Email Address',
            controller: _newEmailController,
            textInputAction: TextInputAction.go,
          ),
          SizedBox(height: 15),
          //Confirm button
          AppButton(
              title: "Update Now",
              onPressed: () {
                // Send email change request
              })
        ],
      ),
    );
  }
}
