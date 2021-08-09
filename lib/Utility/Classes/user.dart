import 'package:green_apple_pay/Utility/Classes/organization.dart';

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

class AppManagedOrganization{
  final String uid;
  final AppOrganization organization;
  double percent;

  AppManagedOrganization({
    required this.uid,
    required this.organization,
    required this.percent,
  });

  Map<String, dynamic> toMap(){
    return {
      'percent': percent,
      'organization_id': organization.uid,
    };
  }

  void updatePercentage(double value){
    percent = value;
  }

  @override
  bool operator ==(Object managedOrganization) =>
      managedOrganization is AppManagedOrganization &&
      managedOrganization.uid == uid;

  @override
  int get hashCode => uid.hashCode;

}