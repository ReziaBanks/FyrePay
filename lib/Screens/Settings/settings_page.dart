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
      body: Padding(
        padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Account Details
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Account Details',
                    style: (Theme.of(context).textTheme.bodyText1).merge(
                      TextStyle(fontWeight: FontWeight.bold)
                    ),
                  )
                ),
                SizedBox(height: 15),

                AppContentTile(
                  title: 'Change Email',
                  onPressed: () {
                  },
                ),

                SizedBox(height: 15),

                AppContentTile(
                  title: 'Security',
                  onPressed: () {
                  },
                )
              ],
            ),
            //Connection
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Connection',
                      style: (Theme.of(context).textTheme.bodyText1).merge(
                          TextStyle(fontWeight: FontWeight.bold)
                      ),
                    )
                ),
                SizedBox(height: 15),

                AppContentTile(
                  title: 'Bank Account Info',
                  onPressed: () {
                  },
                ),

                SizedBox(height: 15),

                AppContentTile(
                  title: 'Donation Settings',
                  onPressed: () {
                  },
                )
              ],
            ),
            //About
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About Green Apple Pay',
                      style: (Theme.of(context).textTheme.bodyText1).merge(
                          TextStyle(fontWeight: FontWeight.bold)
                      ),
                    )
                ),
                SizedBox(height: 15),

                AppContentTile(
                  title: 'Privacy Policy',
                  onPressed: () {
                  },
                ),

                SizedBox(height: 15),

                AppContentTile(
                  title: 'Terms Of Service',
                  onPressed: () {
                  },
                ),

                SizedBox(height: 15),

                AppContentTile(
                  title: 'Logout',
                  titleColor: Color.fromARGB(150, 255, 0, 0),
                  onPressed: () {
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
