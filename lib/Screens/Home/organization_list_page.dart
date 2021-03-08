import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class OrganizationListPage extends StatefulWidget {
  @override
  _OrganizationListPageState createState() => _OrganizationListPageState();
}

class _OrganizationListPageState extends State<OrganizationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizations', style: kAppBarHeavyTextStyle,),
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
