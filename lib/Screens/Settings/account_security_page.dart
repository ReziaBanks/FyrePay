import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';

class AccountSecurityPage extends StatefulWidget {
  @override
  _AccountSecurityPageState createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  String _currentPass;
  String _newPass;
  String _newPass2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Security'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25, left: 50, right: 50, bottom: 50),
        children: [
          //Current Password
          TextFormField(
            obscureText: true,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Current Password",
              filled: true,
              fillColor: Color.fromARGB(255, 234, 234, 234),
            ),
            onSaved: (String v) {
              _currentPass = v;
            },
          ),

          SizedBox(height: 15),

          //New Password
          TextFormField(
            obscureText: true,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter New Password",
              filled: true,
              fillColor: Color.fromARGB(255, 234, 234, 234),
            ),
            onSaved: (String v) {
              _newPass = v;
            },
          ),

          SizedBox(height: 15),

          //Repeat New Password
          TextFormField(
            obscureText: true,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Repeat New Password",
              filled: true,
              fillColor: Color.fromARGB(255, 234, 234, 234),
            ),
            onSaved: (String v) {
              _newPass2 = v;
            },
          ),

          SizedBox(height: 15),
          
          //Confirm button
          AppButton(title: "Update Now", onPressed: () {
            //Hash & send password change request
          })
        ],
      ),
    );
  }
}
