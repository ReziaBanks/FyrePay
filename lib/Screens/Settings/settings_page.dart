import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 50),
        children: [
          //Account Details
          Text(
            'Account Details',
            style: (Theme.of(context).textTheme.bodyText1)
                .merge(TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 15),

          AppContentTile(
            title: 'Change Email',
            onPressed: () {},
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Security',
            onPressed: () {},
          ),
          SizedBox(height: 35),

          //Connection
          Text(
            'Connection',
            style: (Theme.of(context).textTheme.bodyText1)
                .merge(TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 15),

          AppContentTile(
            title: 'Bank Account Info',
            onPressed: () {},
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Donation Settings',
            onPressed: () {},
          ),
          //About
          SizedBox(height: 35),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About Green Apple Pay',
                style: (Theme.of(context).textTheme.bodyText1)
                    .merge(TextStyle(fontWeight: FontWeight.bold)),
              )),
          SizedBox(height: 15),

          AppContentTile(
            title: 'Privacy Policy',
            onPressed: () {},
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Terms Of Service',
            onPressed: () {},
          ),

          SizedBox(height: 15),

          AppContentTile(
            title: 'Logout',
            titleColor: Color.fromARGB(150, 255, 0, 0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
