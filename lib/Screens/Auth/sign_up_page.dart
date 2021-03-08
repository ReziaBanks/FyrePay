import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create An Account'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AppTextField(
                  hintText: 'Enter Your Email Address',
                  controller: null,
                  node: null,
                  textInputAction: null,
                ),
                SizedBox(height: 15),
                AppTextField(
                  hintText: 'Enter Your Email Address',
                  controller: null,
                  node: null,
                  textInputAction: null,
                ),
                SizedBox(height: 15),
                AppTextField(
                  hintText: 'Enter Your Email Address',
                  controller: null,
                  node: null,
                  textInputAction: null,
                ),
                SizedBox(height: 15),
                AppButton(title: 'Register', onPressed: (){}),
              ],
            ),
            Text('Already Have An Account? Login'),
          ],
        ),
      ),
    );
  }
}
