import 'package:flutter/cupertino.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';

class AppDonationV2 {
  final double totalAmountDonated;
  final double amountDonatedToOrg;
  final int orgId;

  AppDonationV2({
    @required this.totalAmountDonated,
    @required this.amountDonatedToOrg,
    @required this.orgId,
  });

  // double get getTotalAmountDonated => totalAmountDonated;
  //
  // double get getAmountDonatedToOrg => amountDonatedToOrg;
}

class AppDonation {
  final String uid;
  final String userId;
  final String organizationId;
  final AppOrganization organization;
  final double cost;
  final double roundUp;
  final String description;
  final DateTime dateCreated;

  AppDonation({
    @required this.uid,
    @required this.userId,
    @required this.organizationId,
    @required this.cost,
    @required this.roundUp,
    @required this.description,
    @required this.dateCreated,
    @required this.organization,
  });

  AppOrganization getOrganization(List<AppOrganization> organizationList) {
    try {
      AppOrganization organization = organizationList.firstWhere((
          organization) => organization.uid == organizationId);
      return organization;
    }
    catch(e){
      print('Error Occurred');
      print(e);
      return null;
    }
  }
}

class AppOrganizationDonation {
  final AppOrganization organization;
  final List<AppDonation> donations;

  double get totalDonation{
    double total = 0;
    for(AppDonation donation in donations){
      total = total + donation.roundUp;
    }
    return total;
  }

  AppOrganizationDonation({
    @required this.organization,
    @required this.donations
});
}