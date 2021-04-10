import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Screens/Auth/login_to_account_page.dart';
import 'package:green_apple_pay/Screens/Settings/account_details_page.dart';
import 'package:green_apple_pay/Screens/Settings/account_security_page.dart';
import 'package:green_apple_pay/Screens/Settings/bank_account_info_page.dart';
import 'package:green_apple_pay/Screens/Settings/donation_settings_page.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

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
      int count = Random().nextInt(3);
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
              title: Text('Settings', style: kAppBarHeavyTextStyle),
              centerTitle: false,
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
                  title: 'Change Email',
                  onPressed: () {
                    AppFunctions.navigate(context, AccountDetailsPage());
                  },
                ),

                SizedBox(height: 15),

                AppContentTile(
                  title: 'Security',
                  onPressed: () {
                    AppFunctions.navigate(context, AccountSecurityPage());
                  },
                ),
                SizedBox(height: 35),

                //Connection
                Text(
                  'Connection',
                  style: _basicStyle,
                ),
                SizedBox(height: 15),

                AppContentTile(
                  title: 'Bank Account Info',
                  onPressed: () {
                    AppFunctions.navigate(context, BankAccountInfoPage());
                  },
                ),

                SizedBox(height: 15),

                AppContentTile(
                  title: 'Donation Settings',
                  onPressed: () {
                    AppFunctions.navigate(context, DonationSettingsPage());
                  },
                ),
                //About
                SizedBox(height: 35),
                Text(
                  'About Green Apple Pay',
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
