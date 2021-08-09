import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_apple_pay/Screens/Explore/explore_page.dart';
import 'package:green_apple_pay/Screens/Home/new_home_page.dart';
import 'package:green_apple_pay/Screens/Organization/discover_organization_page.dart';
import 'package:green_apple_pay/Utility/Functions/app_actions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:provider/provider.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _pageIndex = 0;

  void didChangeDependencies() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    AppActions.getUser(appProvider);
    AppActions.getOrganizations(appProvider);
    AppActions.getDonations(appProvider);
    AppActions.getManagedOrganizations(appProvider);
    super.didChangeDependencies();
  }

  List<Widget> tabPages = [
    NewHomePage(),
    ExplorePage(),
    DiscoverOrganizationPage(),
  ];

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
          backgroundColor: kWhiteColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kGray4DColor,
          onTap: (int index) {
            setState(() {
              _pageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.corporate_fare_outlined),
              activeIcon: Icon(Icons.corporate_fare),
              label: 'Organizations',
            ),
          ],
        ),
      ),
    );
  }
}