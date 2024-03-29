import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Auth/login_to_account_page.dart';
import 'package:green_apple_pay/Screens/Settings/account_email_page.dart';
import 'package:green_apple_pay/Screens/Settings/account_security_page.dart';
import 'package:green_apple_pay/Screens/Settings/my_profile_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

/// Settings Page 
/// This dart class is the main settings page that handles the user preferences. 
/// There are many other pages to navigate through
/// 1. Change Email
/// 2. Security (Change Password)
/// 3. Bank Account Info
/// 4. Donation Settings
/// 5. Privacy Policy
/// 6. Terms of Service

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextStyle _basicStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  bool _showSpinner = false;

  void logout() async{
    AppFunctions.navigateAndRemove(context, LoginToAccount());
    await FirebaseApi().logOutUser();
  }

  void launchUrl(String url) {
    try {
      AppFunctions.launchUrl(url);
    } catch (e) {
      print(e);
    }
  }
  
  void generateDonations(AppProvider appProvider) async{
    User? user = FirebaseApi().getCurrentUser();
    List<AppOrganization>? orgList = appProvider.organizationList;

    if(user == null){
      print('Empty User');
      return;
    }

    if(orgList == null){
      Fluttertoast.showToast(msg: 'An Error Occurred');
      return;
    }

    if(orgList.isEmpty){
      Fluttertoast.showToast(msg: 'No Available Organization');
      return;
    }

    setState(() {
      _showSpinner = true;
    });
    try{
      String userId = user.uid;
      int count = Random().nextInt(3) + 1;
      while(count > 0){
        String orgId = (orgList..shuffle()).first.uid;
        Map<String, dynamic> data = AppFunctions.generateRandomDonation(orgId, userId);
        await FirebaseApi().addDonation(data);
        count -= 1;
      }
      AppActions.getDonations(appProvider);
      Fluttertoast.showToast(msg: 'Donation Added');
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: 'An Error Occurred');
    }
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return ModalProgressHUD(
          inAsyncCall: _showSpinner,
          progressIndicator: AppProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              leading: AppBackIconButton(),
              title: Text('Settings', style: kAppBarHeavyTextStyle),
              centerTitle: true,
            ),
            body: ListView(
              padding: kAppPadding,
              children: [
                //Account Details
                Text(
                  'Account Details',
                  style: _basicStyle,
                ),
                SizedBox(height: 15),
                AppContentTile(
                  title: 'My Profile',
                  onPressed: (){
                    AppFunctions.navigate(context, MyProfilePage());
                  },
                ),
                SizedBox(height: 15),
                AppContentTile(
                  title: 'Change Email',
                  onPressed: () {
                    AppFunctions.navigate(context, AccountEmailPage());
                  },
                ),

                SizedBox(height: 15),

                AppContentTile(
                  title: 'Security',
                  onPressed: () {
                    AppFunctions.navigate(context, AccountSecurityPage());
                  },
                ),

                //About
                SizedBox(height: 35),
                Text(
                  'About Green Apple',
                  style: _basicStyle,
                ),
                SizedBox(height: 15),

                AppContentTile(
                  title: 'Privacy Policy',
                  onPressed: () {
                    launchUrl('${AppData.defaultUrl}');
                  },
                ),
                SizedBox(height: 15),
                AppContentTile(
                  title: 'Terms Of Service',
                  onPressed: () {
                    launchUrl('${AppData.defaultUrl}');
                  },
                ),
                SizedBox(height: 15),
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.2,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Add',
                      color: Colors.black45,
                      icon: Icons.add,
                      onTap: (){
                        generateDonations(appProvider);
                      },
                    ),
                  ],
                  child: AppContentTile(
                    title: 'Generate Donations',
                  ),
                ),
                SizedBox(height: 15),
                AppContentTile(
                  title: 'Logout',
                  titleColor: Color.fromARGB(150, 255, 0, 0),
                  onPressed: () {
                    logout();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
