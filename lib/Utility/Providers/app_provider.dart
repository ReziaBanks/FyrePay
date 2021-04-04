import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';

class AppProvider extends ChangeNotifier{
  AppUser appUser;
  List<AppOrganization> organizationList = [];
  List<AppDonation> donationList = [];
  List<AppManagedOrganization> managedOrganizationList = [];

  List<DateTime> get dateList {
    List<DateTime> dateList = [];
    if(donationList != null){
      for(AppDonation donation in donationList){
        if(dateList.isEmpty){
          dateList.add(donation.dateCreated);
        }
        else{
          List<DateTime> newList = dateList.where((element) => element.isSameDate(donation.dateCreated)).toList();
          if(newList.isEmpty){
            dateList.add(donation.dateCreated);
          }
        }
      }
      return dateList;
    }
    else return [];
  }

  double get totalDonation {
    double total = 0;
    for(AppDonation donation in donationList){
      total += donation.roundUp;
    }
    return total;
  }

  void updateAppUser(AppUser user){
    appUser = user;
    notifyListeners();
  }

  void updateOrganizationList(List<AppOrganization> valueList){
    organizationList = valueList;
    notifyListeners();
  }

  void updateManagedOrganizationList(List<AppManagedOrganization> valueList){
    managedOrganizationList = valueList;
    notifyListeners();
  }
  
  void updateDonationList(List<AppDonation> valueList){
    donationList = valueList;
    notifyListeners();
  }
}


extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
        && this.day == other.day;
  }
}