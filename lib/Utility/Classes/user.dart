import 'package:flutter/cupertino.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';

class AppUser {
  final String uid;
  final String email;
  final AppUserSettings settings;

  AppUser({
    @required this.uid,
    @required this.email,
    @required this.settings,
  });
}

class AppUserSettings {
  final double roundUpAmount;
  final double monthlyAddOn;
  final double maxMonthlyDonation;

  AppUserSettings({
    @required this.roundUpAmount,
    @required this.monthlyAddOn,
    @required this.maxMonthlyDonation,
  });
}

class AppManagedOrganization{
  final String uid;
  final AppOrganization organization;
  bool status;
  double percent;

  AppManagedOrganization({
    @required this.uid,
    @required this.organization,
    @required this.status,
    @required this.percent,
  });

  Map<String, dynamic> toMap(){
    return {
      'status': status,
      'percent': percent,
      'organization_id': organization?.uid,
    };
  }

  void updateStatus(bool value){
    status = value;
  }

  void updatePercentage(double value){
    if(value != null){
      percent = value;
    }
  }

  @override
  bool operator ==(Object managedOrganization) => managedOrganization is AppManagedOrganization && managedOrganization.uid == uid;

  @override
  int get hashCode => uid.hashCode;

}