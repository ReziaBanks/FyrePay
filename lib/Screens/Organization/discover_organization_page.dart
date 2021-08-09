import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
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
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
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
                    separatorBuilder: (context, index) => SizedBox(height: 20),
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
    });
  }
}

class OrganizationCardV2 extends StatelessWidget {
  final AppOrganization organization;
  OrganizationCardV2(this.organization);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          AppFunctions.navigate(context, OrganizationPage(organization));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: kDividerColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    organization.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: kLetterSpacing,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share(
                          'Visit ${organization.website} to learn more about ${organization.name}');
                    },
                    child: Icon(
                      Ionicons.share_outline,
                      color: kGray4DColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              AppDivider(),
              SizedBox(height: 20),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: organization.imageURL,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      organization.about,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kGray4DColor,
                        height: 1.55,
                        fontSize: 14.5,
                        letterSpacing: kLetterSpacing,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              AppDivider(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Color(0xFF62BB46),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        '50%',
                        style: TextStyle(
                          letterSpacing: kLetterSpacing,
                          color: kWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Learn More',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: kLetterSpacing,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
