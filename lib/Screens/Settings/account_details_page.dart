import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  String _newEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Security'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25, left: 50, right: 50, bottom: 50),
        children: [
          //Current Email
        InkWell(
            child: Container(
              height: 60,
              color: Color(0xFFECECEC),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Email',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'example@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontStyle: FontStyle.italic,
                    )
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 15),

          //New Password
          TextFormField(
            obscureText: true,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter New Email Address",
              filled: true,
              fillColor: Color.fromARGB(255, 234, 234, 234),
            ),
            onSaved: (String v) {
              _newEmail = v;
            },
          ),

          SizedBox(height: 15),

          //Confirm button
          AppButton(title: "Update Now", onPressed: () {
            //Send email change request
          })
        ],
      ),
    );
  }
}
