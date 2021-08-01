import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Organization/organization_page.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'manage_organization_page.dart';

class OrganizationListPage extends StatefulWidget {
  @override
  _OrganizationListPageState createState() => _OrganizationListPageState();
}

class _OrganizationListPageState extends State<OrganizationListPage> {
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
      color: Color(0xFFF8F9FA),
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
                color: Color(0xFFDFE5E8),
              ),),
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
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Fluttertoast.showToast(msg: 'Link Copied');
                    },
                    child: Icon(LineIcons.share,),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFDFE5E8),
              ),
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
                        height: 1.5,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFDFE5E8),
              ),
              SizedBox(height: 15),
              Text(
                'Learn More',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
