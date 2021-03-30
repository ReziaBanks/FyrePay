import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
// import 'package:toast/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountSecurityPage extends StatefulWidget {
  @override
  _AccountSecurityPageState createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Security', style: kAppBarLightTextStyle),
      ),
      body: ListView(
          padding: kAppPadding,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      //Current Password
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Enter Current Password',
                            errorText: checkCurrentPasswordValid
                                ? null
                                : "Please double check your current password"),
                        controller: _currentPasswordController,
                      ),
                      SizedBox(height: 15),
                      //New Password
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter New Password',
                        ),
                        obscureText: true,
                        controller: _newPasswordController,
                      ),
                      SizedBox(height: 15),
                      //Repeat New Password
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Repeat New Password',
                        ),
                        obscureText: true,
                        controller: _repeatPasswordController,
                        validator: (value) {
                          return _newPasswordController.text == value
                              ? null
                              : "Please validate your entered password";
                        },
                      ),
                      SizedBox(height: 15),
                      //Confirm button
                      AppButton(
                        title: "Update Now",
                        onPressed: () async {
                          //Hash & send password change request
                          FirebaseApi _firebaseApi = FirebaseApi();

                          checkCurrentPasswordValid =
                              await _firebaseApi.validatePassword(
                                  _currentPasswordController.text);

                          setState(() {});
                          if (_formKey.currentState.validate() &&
                              checkCurrentPasswordValid) {
                            await _firebaseApi
                                .updatePassword(_newPasswordController.text);
                            FocusScope.of(context).unfocus();
                            Fluttertoast.showToast(
                                msg: "Successfuly Updated Password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green[900],
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                      )
                    ],
                  )),
            )
          ]),
    );
  }
}
