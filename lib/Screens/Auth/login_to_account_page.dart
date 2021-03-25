import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Auth/password_reset_page.dart';
import 'package:green_apple_pay/Screens/Home/tab_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

import 'create_account_page.dart';

class LoginToAccount extends StatefulWidget {
  @override
  _LoginToAccountState createState() => _LoginToAccountState();
}

class _LoginToAccountState extends State<LoginToAccount> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showSpinner = false;

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
        Toast.show('Email Field Empty', context);
        return;
      }

      if(password.isEmpty){
        Toast.show('Password Field Empty', context);
        return;
      }

      User user = await FirebaseApi().signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        AppFunctions.navigateAndRemove(context, TabPage());
      }
      else {
        Toast.show("Toast plugin app", context);
      }
    }
    catch(e){
      print(e);
      Toast.show('${e.message}', context, duration: Toast.LENGTH_LONG, );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
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
