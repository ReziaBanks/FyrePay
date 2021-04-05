import 'package:flutter/material.dart';
import 'package:green_apple_pay/Components/Donation/donation_component.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Functions/app_functions.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:green_apple_pay/Utility/Misc/extension.dart';

class AllDonationsPage extends StatefulWidget {
  @override
  _AllDonationsPageState createState() => _AllDonationsPageState();
}

class _AllDonationsPageState extends State<AllDonationsPage> {
  List<AppDonation> getDonationListByDate(
      AppProvider appProvider, DateTime dateTime) {
    List<AppDonation> donationList = appProvider.donationList;
    List<AppDonation> filteredDonationList = [];
    for (AppDonation donation in donationList) {
      if (donation.dateCreated.isSameDate(dateTime)) {
        filteredDonationList.add(donation);
      }
    }
    return filteredDonationList;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        List<AppDonation> donationList = appProvider.donationList;
        return Scaffold(
          backgroundColor: Color(0xFFF3F5F5),
          appBar: AppBar(
            title: Text(
              'All Donations',
              style: kAppBarLightTextStyle,
            ),
          ),
          body: donationList.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.only(top: 25, bottom: 50),
                  itemCount: appProvider.dateList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 25),
                  itemBuilder: (context, index) {
                    DateTime dateTime = appProvider.dateList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            '${AppFunctions.dateToString(dateTime).toUpperCase()}',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: kGray4DColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              getDonationListByDate(appProvider, dateTime)
                                  .length,
                          itemBuilder: (context, index) {
                            AppDonation donation = getDonationListByDate(
                                appProvider, dateTime)[index];
                            return AppDonationTile(donation: donation);
                          },
                        ),
                      ],
                    );
                  })
              : Center(child: Text('No Available Donation')     ),
        );
      },
    );
  }
}
