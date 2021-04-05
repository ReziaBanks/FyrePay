import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AccountSecurityPage extends StatefulWidget {
  @override
  _AccountSecurityPageState createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  bool _showSpinner = false;

  void updatePassword() async{

    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String repeatNewPassword = _repeatPasswordController.text;

    if(currentPassword.isEmpty && newPassword.isEmpty && repeatNewPassword.isEmpty){
      Fluttertoast.showToast(msg: 'Text Field Is Empty');
      return;
    }

    if(repeatNewPassword != newPassword){
      Fluttertoast.showToast(msg: 'New password does not match repeat password');
      return;
    }

    setState(() {
      _showSpinner = true;
    });
    try {
      User user = FirebaseApi().getCurrentUser();
      if(user != null) {
        User newUser = await FirebaseApi().signInWithEmailAndPassword(
          email: '${user.email}', password: currentPassword,);
        if (newUser != null) {
          await FirebaseApi().updatePassword(newPassword);
          Fluttertoast.showToast(msg: 'Password Updated');
          _currentPasswordController.clear();
          _repeatPasswordController.clear();
          _newPasswordController.clear();
        }
        else {
          Fluttertoast.showToast(msg: 'An error occurred, password is incorrect');
        }
      }
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: 'An error occurred');
    }
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      progressIndicator: AppProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Account Security', style: kAppBarLightTextStyle),
        ),
        body: ListView(
          padding: kAppPadding,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            AppTextField(
              hintText: 'Enter Current Password',
              controller: _currentPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 15),
            AppTextField(
              hintText: 'Enter New Password',
              controller: _newPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 15),
            AppTextField(
              hintText: 'Repeat New Password',
              controller: _repeatPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 15),
            AppButton(
              title: "Update Now",
              onPressed: () {
                updatePassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}