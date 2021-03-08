import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  TextEditingController emailController = TextEditingController();
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: GestureDetector(
        onTap: () {
          AppFunctions.unFocusPage(context);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Password Reset',
              style: kAppBarLightTextStyle,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Text(
                  '${AppData.passwordResetText}',
                  style: TextStyle(
                    color: kGray4DColor,
                    height: 135 / 100,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 15),
                AppTextField(
                  hintText: 'Enter Your Email Address',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  obscureText: false,
                  textInputAction: TextInputAction.go,
                  onEditingComplete: () {
                  },
                ),
                SizedBox(height: 15),
                AppButton(
                    title: 'Submit',
                    onPressed: () {
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
