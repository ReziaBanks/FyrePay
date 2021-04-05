import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Screens/Donations/home_page.dart';
import 'package:green_apple_pay/Screens/Organization/organization_list_page.dart';
import 'package:green_apple_pay/Screens/Settings/settings_page.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:provider/provider.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  void didChangeDependencies() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    AppActions.getUser(appProvider);
    AppActions.getOrganizations(appProvider);
    AppActions.getDonations(appProvider);
    AppActions.getManagedOrganizations(appProvider);
    super.didChangeDependencies();
  }

  List<Widget> tabPages = [HomePage(), OrganizationListPage(), SettingsPage()];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBottomNavBarColor,
      body: tabPages[_pageIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: kBottomNavBarColor,
        ),
        child: BottomNavigationBar(
          backgroundColor: kBottomNavBarColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kBlackColor,
          onTap: (int index) {
            setState(() {
              _pageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.briefcase),
              label: 'Organization List',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings_solid),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}