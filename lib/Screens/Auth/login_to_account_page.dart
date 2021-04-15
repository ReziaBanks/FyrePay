import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Auth/password_reset_page.dart';
import 'package:green_apple_pay/Screens/Tab/tab_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'create_account_page.dart';

/// Represents a page that allows the user to login using an email address and password
/// User is able to reset their password through this page.
///
/// User is able to register through this page if they don't already have an account

class LoginToAccount extends StatefulWidget {
  @override
  _LoginToAccountState createState() => _LoginToAccountState();
}

class _LoginToAccountState extends State<LoginToAccount> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showSpinner = false;

  // Displays animation while processing the creation of an account
  void spinnerCall() async{
    setState(() {
      _showSpinner = true;
    });
    await loginToAccount();
    setState(() {
      _showSpinner = false;
    });
  }

  Future<void> loginToAccount() async{
    try {
      String email = _emailController.text;
      String password = _passwordController.text;

      if(email.isEmpty){
        Fluttertoast.showToast(msg: 'Email Field Empty');
        return;
      }

      if(password.isEmpty){
        Fluttertoast.showToast(msg: 'Password Field Empty');
        return;
      }

      User? user = await FirebaseApi().signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        AppFunctions.navigateAndRemove(context, TabPage());
      }
      else {
        Fluttertoast.showToast(msg: 'Error Occurred');
      }
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Login To Account',
              style: kAppBarLightTextStyle,
            ),
            centerTitle: true,
            actions: [
              AppBarTextButton(
                title: 'Reset',
                onPressed: () {
                  AppFunctions.navigate(context, PasswordResetPage());
                },
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      AppTextField(
                        hintText: 'Enter Your Email Address',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        obscureText: false,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 15),
                      AppTextField(
                        hintText: 'Enter Your Password',
                        obscureText: true,
                        controller: _passwordController,
                        textInputAction: TextInputAction.go,
                        onEditingComplete: () {
                          spinnerCall();
                        },
                      ),
                      SizedBox(height: 15),
                      AppButton(
                        title: 'Sign In',
                        onPressed: () {
                          spinnerCall();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don’t Have An Account? ",
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          color: kBlackColor,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppFunctions.navigate(context, CreateAccount());
                              },
                            text: 'Register Now',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
