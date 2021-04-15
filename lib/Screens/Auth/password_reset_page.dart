import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/// Represents a page that allows the user to reset their password given a valid email
/// Sends a password reset email to the specified email if that email exists

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  TextEditingController _emailController = TextEditingController();
  bool _showSpinner = false;

  // Displays animation while processing the creation of an account
  void spinnerUpdate() async{
    setState(() {
      _showSpinner = true;
    });
    await resetPassword();
    setState(() {
      _showSpinner = false;
    });
  }

  Future<void> resetPassword() async{
    try {
      String email = _emailController.text;

      if (email.isEmpty) {
        Fluttertoast.showToast(msg: 'Email Field Is Empty');
        return;
      }

      await FirebaseApi().sendResetEmail(email);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Password Reset Email Sent');
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: 'An Error Occurred', toastLength: Toast.LENGTH_LONG);
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: AppProgressIndicator(),
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
                  controller: _emailController,
                  obscureText: false,
                  textInputAction: TextInputAction.go,
                  onEditingComplete: () {
                    spinnerUpdate();
                  },
                ),
                SizedBox(height: 15),
                AppButton(
                    title: 'Submit',
                    onPressed: () {
                      spinnerUpdate();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
