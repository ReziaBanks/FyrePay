import 'package:green_apple_pay/Utility/Classes/organization.dart';

///Defines a class that represents everything about a user and their settings
class AppUser {
  final String uid;
  final String? email;
  final AppUserSettings settings;

  AppUser({
    required this.uid,
    required this.email,
    required this.settings,
  });
}

///Defines a class that represents a user's settings
class AppUserSettings {
  final double? roundUpAmount;
  final double? monthlyAddOn;
  final double? maxMonthlyDonation;

  AppUserSettings({
    this.roundUpAmount,
    this.monthlyAddOn,
    this.maxMonthlyDonation,
  });
}

///Defines a class that represents a percentage of a organization that the user wants to donate to
class AppManagedOrganization{
  final String uid;
  final AppOrganization organization;
  bool status;
  double percent;

  AppManagedOrganization({
    required this.uid,
    required this.organization,
    required this.status,
    required this.percent,
  });

  Map<String, dynamic> toMap(){
    return {
      'status': status,
      'percent': percent,
      'organization_id': organization.uid,
    };
  }

  void updateStatus(bool value){
    status = value;
  }

  void updatePercentage(double value){
    percent = value;
  }

  @override
  bool operator ==(Object managedOrganization) => managedOrganization is AppManagedOrganization && managedOrganization.uid == uid;

  @override
  int get hashCode => uid.hashCode;

}