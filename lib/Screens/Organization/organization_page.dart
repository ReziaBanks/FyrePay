import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';

class OrganizationPage extends StatefulWidget {
  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  TextStyle _basicTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double imageHeight = phoneWidth * (3 / 4);
      return Scaffold(
        appBar: AppBar(
          title: Text('Wounded Warriors', style: kAppBarLightTextStyle,),
        ),
        body: ListView(
          children: [
            CachedNetworkImage(
              imageUrl: '${AppData.organizationImageUrl3}',
              fit: BoxFit.cover,
              width: phoneWidth,
              height: imageHeight,
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organization Details', style: _basicTextStyle),
                  SizedBox(height: 15),
                  AppListTile(
                    text: 'Name: Wounded Warriors',
                    iconData: Icons.fiber_manual_record,
                    iconSize: 15,
                  ),
                  SizedBox(height: 15),
                  AppListTile(
                    text: 'Website: www.woundedwarriorproject.org',
                    iconData: Icons.fiber_manual_record,
                    iconSize: 15,
                  ),
                  SizedBox(height: 15),
                  AppListTile(
                    text:
                    'Email: info@wondedwarriors.ca',
                    iconData: Icons.fiber_manual_record,
                    iconSize: 15,
                  ),
                  SizedBox(height: 25),
                  Text('About Us', style: _basicTextStyle),
                  SizedBox(height: 10),
                  Text(
                    '${AppData.organizationDescr1}',
                    style: TextStyle(
                      fontSize: 16,
                      height: 170 / 100,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text('Address', style: _basicTextStyle),
                  SizedBox(height: 10),
                  Text(
                    '${AppData.organizationAddress1}',
                    style: TextStyle(
                      fontSize: 16,
                      height: 170 / 100,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      );
  }
}