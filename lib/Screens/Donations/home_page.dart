import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Basic/app_components.dart';
import 'package:green_apple_pay/Components/Organization/organization_component.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'all_donations_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppOrganizationDonation>? orgDonationList =
            appProvider.organizationDonationList;
        return Scaffold(
          appBar: AppBar(
            title: Text('Green Apple Pay', style: kAppBarHeavyTextStyle),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(Icons.receipt),
                onPressed: () {
                  AppFunctions.navigate(context, AllDonationsPage());
                },
              ),
            ],
          ),
          body: orgDonationList != null
              ? orgDonationList.isNotEmpty
                  ? ListView(
                      padding: kAppPadding,
                      children: [
                        AppButton(
                          title:
                              'Life Time Donations: \$${appProvider.totalDonation}',
                        ),
                        SizedBox(height: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: orgDonationList.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemBuilder: (context, index) {
                              AppOrganizationDonation organizationDonation =
                                  orgDonationList[index];
                              return AppMiniOrganizationCard(
                                  organizationDonation: organizationDonation);
                            }),
                      ],
                    )
                  : Center(child: Text('No Available Donation'))
              : Center(child: AppProgressIndicator()),
        );
      },
    );
  }
}
