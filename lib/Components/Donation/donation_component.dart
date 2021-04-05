import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class AppDonationTile extends StatelessWidget {
  final AppDonation donation;
  AppDonationTile({@required this.donation});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhiteColor,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Color(0xFFC6C6C8),
                  )
              )
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${donation?.organization?.name} (${donation?.description})', style: TextStyle(
                fontSize: 15,
              ),),
              Text('\$${donation?.roundUp}', style: TextStyle(
                fontSize: 15,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}