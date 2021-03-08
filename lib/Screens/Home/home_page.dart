import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green Apple Pay', style: kAppBarHeavyTextStyle),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: kAppPadding,
        children: [

        ],
      ),
    );
  }
}