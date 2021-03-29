import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:toast/toast.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  String _currentEmail = FirebaseApi().getCurrentUser().email;
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
              _currentEmail,
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
              onPressed: () async {
                try {
                  FirebaseApi _firebaseApi = FirebaseApi();

                  User user = await _firebaseApi.signInWithEmailAndPassword(email: _firebaseApi.getCurrentUser().email, password: _passwordController.value.text);
                  if (user != null) {
                    //Update user email
                    await _firebaseApi.updateEmail(_newEmailController.value.text);
                    //Update email text
                    setState(() {
                      _currentEmail = FirebaseApi().getCurrentUser().email;
                    });

                    Toast.show("Successfully updated email", context);
                  }
                  else {
                    Toast.show("Toast plugin app", context);
                  }
                  // Send email change request
                  await _firebaseApi.updateEmail(_newEmailController.value.text);
                } catch (e) {
                  print(e);
                  Toast.show('${e.message}', context, duration: Toast.LENGTH_LONG, );
                }

              })
        ],
      ),
    );
  }
}
