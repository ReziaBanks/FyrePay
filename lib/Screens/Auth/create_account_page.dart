import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Auth/login_to_account_page.dart';
import 'package:green_apple_pay/Screens/Connection/connect_bank_account_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  bool _showSpinner = false;

  void launchUrl(String url) {
    try {
      AppFunctions.launchUrl(url);
    } catch (e) {
      print(e);
    }
  }

  void spinnerUpdate() async{
    setState(() {
      _showSpinner = true;
    });
    await createAccount();
    setState(() {
      _showSpinner = false;
    });
  }

  Future<void> createAccount() async {
    try {
      String email = _emailController.text;
      String password = _passwordController.text;
      String repeatPassword = _repeatPasswordController.text;

      if(email.isEmpty){
        Fluttertoast.showToast(msg: 'Email is Empty');
        return;
      }

      if(password.isEmpty){
        Fluttertoast.showToast(msg: 'Empty Password Field');
        return;
      }

      if(repeatPassword != password){
        Fluttertoast.showToast(msg: 'Repeat Password not equals to Password', toastLength: Toast.LENGTH_LONG);
        return;
      }

      User? user = await FirebaseApi().signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(user != null){
        AppFunctions.navigateAndRemove(context, ConnectBankAccountPage());
      }
      else{
        Fluttertoast.showToast(msg: 'Error Creating An Account', toastLength: Toast.LENGTH_LONG);
      }

    } catch (e) {
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
            centerTitle: true,
            title: Text(
              'Create An Account',
              style: kAppBarLightTextStyle,
            ),
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
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 15),
                      AppTextField(
                        hintText: 'Repeat Your Password',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        controller: _repeatPasswordController,
                        // onEditingComplete: () {
                        //   createAnAccount(appProvider);
                        // },
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: "By creating an account you're agreeing to our ",
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 17,
                            height: 150 / 100,
                            color: kBlackColor,
                            fontWeight: FontWeight.w300,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launchUrl('${AppData.defaultUrl}');
                                },
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launchUrl('${AppData.defaultUrl}');
                                },
                              text: 'Terms Of Condition.',
                              style: TextStyle(
                                //fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      AppButton(
                        title: 'Register',
                        onPressed: () {
                          spinnerUpdate();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already Have An Account? ',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          color: kBlackColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppFunctions.navigate(
                                    context, LoginToAccount());
                              },
                            text: 'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
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
