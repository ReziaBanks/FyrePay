import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

/// Represents the Account Details page, where a logged-in user can change their email given a new email input
/// and their current password.
///
/// If inputs are valid, asynchronously will make an API request to update their email and refresh their session.
/// Updates the Current Email label upon successfully changing their email.

class AccountEmailPage extends StatefulWidget {
  @override
  _AccountEmailPageState createState() => _AccountEmailPageState();
}

class _AccountEmailPageState extends State<AccountEmailPage> {
  /// Checks if user exist and stores the user current email in the current email text field 
  String? _currentEmail = FirebaseApi().getCurrentUser()!.email;

  // Handles the new email text field
  TextEditingController _newEmailController = TextEditingController();
  // Handles the password text field
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackIconButton(),
        title: Text('Account Email', style: kAppBarLightTextStyle),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: kAppPadding,
        children: [
          //Current Email
          AppContentTile(
            title: 'Current Email',
            height: 55,
            trailingWidget: Expanded(
              child: Text(
                _currentEmail != null ? _currentEmail! : '...',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  color: kGray85Color,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          AppTextField(
            hintText: 'Enter Current Password',
            controller: _passwordController,
            obscureText: true,
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
                // Refreshes the user to ensure that the session is still valid
                User? user = await _firebaseApi.signInWithEmailAndPassword(
                    email: _firebaseApi.getCurrentUser()!.email!,
                    password: _passwordController.value.text);
                if (user != null) {
                  //Update user email
                  await _firebaseApi
                      .updateEmail(_newEmailController.value.text);
                  //Update email text
                  setState(() {
                    _currentEmail = FirebaseApi().getCurrentUser()!.email;
                  });

                  Fluttertoast.showToast(msg: "Successfully updated email");
                } else {
                  Fluttertoast.showToast(msg: 'Error occurred');
                }
                // Send email change request
                await _firebaseApi.updateEmail(_newEmailController.value.text);
              } catch (e) {
                print(e);
                Fluttertoast.showToast(msg: 'An Error Occurred', toastLength: Toast.LENGTH_LONG);
              }
            },
          )
        ],
      ),
    );
  }
}
