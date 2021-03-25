import 'package:flutter/cupertino.dart';

class AppDonation {
  final double totalAmountDonated;
  final double amountDonatedToOrg;
  final int orgId;

  AppDonation({
    @required this.totalAmountDonated,
    @required this.amountDonatedToOrg,
    @required this.orgId,
  });

  // double get getTotalAmountDonated => totalAmountDonated;
  //
  // double get getAmountDonatedToOrg => amountDonatedToOrg;
}
