import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Misc/extension.dart';

/// All global variables that are used commonly throughout the app

class AppProvider extends ChangeNotifier{
  AppUser? appUser; //The logged-in user

  List<AppOrganization>? organizationList; //List of organizations from db
  List<AppDonation>? donationList; //List of donations from db
  List<AppManagedOrganization>? managedOrganizationList; //List of managed-organizations

  //Gets the different dates from a full donation list
  List<DateTime> get dateList {
    List<DateTime> dateList = [];

    if(donationList != null) {
      for (AppDonation donation in donationList!){
        if (dateList.isEmpty) {
          dateList.add(donation.dateCreated);
        }
        else {
          List<DateTime> newList = dateList.where((element) =>
              element.isSameDate(donation.dateCreated)).toList();
          if (newList.isEmpty) {
            dateList.add(donation.dateCreated);
          }
        }
      }
      return dateList;
    }
    else return [];
  }

  //Gets the total donation amount made to all organizations.
  double get totalDonation {
    double total = 0;
    if(donationList != null) {
      for (AppDonation donation in donationList!) {
        total += donation.roundUp;
      }
      return total.toPrecision(2);
    }
    else return total;
  }

  //Separates all donations filtered by organization
  List<AppOrganizationDonation>? get organizationDonationList{
    List<AppOrganizationDonation> organizationDonationList = [];
    if(donationList == null || organizationList == null){
      return null;
    }
    if(organizationList != null) {
        for (AppOrganization organization in organizationList!) {
          List<AppDonation> selectedDonations = [];
          if (donationList != null) {
            for (AppDonation donation in donationList!) {
              if (donation.organization.uid == organization.uid) {
                selectedDonations.add(donation);
              }
            }
          }
          if (selectedDonations.isNotEmpty) {
            AppOrganizationDonation organizationDonation =
            AppOrganizationDonation(
              organization: organization,
              donations: selectedDonations,
            );
            organizationDonationList.add(organizationDonation);
          }
        }
      }
    return organizationDonationList;
  }

  ///Functions to updates global variables

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


