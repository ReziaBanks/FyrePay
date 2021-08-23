import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class OrganizationPage extends StatefulWidget {
  final AppOrganization organization;
  OrganizationPage(this.organization);

  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  TextStyle _basicTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    letterSpacing: kLetterSpacing,
  );
  bool _showSpinner = false;

  void toggleAction(AppProvider appProvider) async{
    User? user = FirebaseApi().getCurrentUser();
    AppOrganization organization = widget.organization;
    if(user == null){
      print('Empty User');
      return;
    }

    setState(() {
      _showSpinner = true;
    });
    try{
      String userId = user.uid;
      String orgId = organization.uid;

      await FirebaseApi().toggleUserManagedOrganization(userId, orgId);
      AppActions.getManagedOrganizations(appProvider);
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: 'Error Occurred', );
    }
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double imageHeight = phoneWidth * (3 / 4);
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppManagedOrganization>? managedOrgList = appProvider.managedOrganizationList;
        List<AppManagedOrganization> newList = [];
        if(managedOrgList != null) {
          newList =
              managedOrgList.where((element) => element.organization.uid ==
                  widget.organization.uid).toList();
        }
        return ModalProgressHUD(
          progressIndicator: AppProgressIndicator(),
          inAsyncCall: _showSpinner,
          child: Scaffold(
            appBar: AppBar(
              leading: AppBackIconButton(),
              title: Text(
                widget.organization.name,
                style: kAppBarLightTextStyle,
              ),
            ),
            body: ListView(
              padding: kAppPadding.copyWith(top: 15),
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.organization.imageURL,
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Organization Details', style: _basicTextStyle),
                    SizedBox(height: 15),
                    AppListTile(
                      text: 'Name: ${widget.organization.name}',
                      iconData: Icons.fiber_manual_record,
                      iconSize: 13,
                    ),
                    SizedBox(height: 15),
                    AppListTile(
                      text: 'Website: ${widget.organization.website}',
                      iconData: Icons.fiber_manual_record,
                      iconSize: 13,
                    ),
                    SizedBox(height: 15),
                    AppListTile(
                      text: 'Email: ${widget.organization.email}',
                      iconData: Icons.fiber_manual_record,
                      iconSize: 13,
                    ),
                    SizedBox(height: 25),
                    Text('About Us', style: _basicTextStyle),
                    SizedBox(height: 10),
                    Text(
                      widget.organization.about,
                      style: TextStyle(
                        fontSize: 16,
                        height: 170 / 100,
                        fontWeight: FontWeight.w300,
                        letterSpacing: kLetterSpacing,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text('Address', style: _basicTextStyle),
                    SizedBox(height: 10),
                    Text(
                      widget.organization.address,
                      style: TextStyle(
                        fontSize: 16,
                        height: 170 / 100,
                        fontWeight: FontWeight.w300,
                        letterSpacing: kLetterSpacing,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
