import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Organization/organization_component.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'manage_organization_page.dart';

class OrganizationListPage extends StatefulWidget {
  @override
  _OrganizationListPageState createState() => _OrganizationListPageState();
}

class _OrganizationListPageState extends State<OrganizationListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppOrganization> organizationList = appProvider.organizationList;
        return Scaffold(
          appBar: AppBar(
            title: Text('Organizations', style: kAppBarHeavyTextStyle,),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(Icons.account_balance_sharp),
                onPressed: () {
                  AppFunctions.navigate(context, ManageOrganizationPage());
                },
              ),
            ],
          ),
          body: ListView.separated(
            padding: kAppPadding,
            itemCount: organizationList.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index) {
              AppOrganization organization = organizationList[index];
              return AppOrganizationCard(organization: organization);
            },
          ),
        );
      }
    );
  }
}


