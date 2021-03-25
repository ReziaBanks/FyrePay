import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Misc/data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AppOrganization> organizations = [AppData.org1, AppData.org2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green Apple Pay', style: kAppBarHeavyTextStyle),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: kAppPadding,
        children: [
          AppButton(
            title: 'Life Time Donations: \$38.73',
          ),
          SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: organizations.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index){
              AppOrganization organization = organizations[index];
              return AppMiniOrganizationCard(organization: organization);
            }
          ),
        ],
      ),
    );
  }
}

