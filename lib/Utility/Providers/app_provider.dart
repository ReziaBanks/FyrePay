import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';

class AppProvider extends ChangeNotifier{
  List<AppOrganization> organizationList;
  List<AppDonation> donationList;
  
  void updateOrganizationList(List<AppOrganization> valueList){
    organizationList = valueList;
    notifyListeners();
  }
  
  void updateDonationList(List<AppDonation> valueList){
    donationList = valueList;
    notifyListeners();
  }
}