import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Components/Organization/organization_component.dart';
import 'package:green_apple_pay/Screens/Organization/organization_page.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'manage_organization_page.dart';

class DiscoverOrganizationPage extends StatefulWidget {
  @override
  _DiscoverOrganizationPageState createState() =>
      _DiscoverOrganizationPageState();
}

class _DiscoverOrganizationPageState extends State<DiscoverOrganizationPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppOrganization>? orgList = appProvider.organizationList;
        return Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            title: Text(
              'Organizations',
              style: kAppBarHeavyTextStyle,
            ),
            centerTitle: true,
            bottom: AppBasic.appBarBorder(),
            actions: [
              IconButton(
                icon: Icon(Icons.account_balance_sharp),
                onPressed: () {
                  AppFunctions.navigate(context, ManageOrganizationPage());
                },
              ),
            ],
          ),
          body: orgList != null
              ? orgList.isNotEmpty
                  ? ListView.separated(
                      padding: kAppPadding,
                      itemCount: orgList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        AppOrganization organization = orgList[index];
                        return OrganizationCardV2(organization);
                      },
                    )
                  : Center(
                      child: Text('No Available Organization'),
                    )
              : Center(child: AppProgressIndicator()),
        );
      },
    );
  }
}
