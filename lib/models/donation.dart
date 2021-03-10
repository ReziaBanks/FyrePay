class Donation {
  double totalAmountDonated;
  double amountDonatedToOrg;
  int orgId;

  Donation({this.totalAmountDonated, this.amountDonatedToOrg, this.orgId});

  double get getTotalAmountDonated => totalAmountDonated;

  double get getAmountDonatedToOrg => amountDonatedToOrg;
}
