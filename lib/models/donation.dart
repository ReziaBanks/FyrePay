class Donation {
  double _totalAmountDonated;
  double _amountDonatedToOrg;
  int orgId;

  Donation(this._totalAmountDonated, this._amountDonatedToOrg, this.orgId);

  double get totalAmountDonated => _totalAmountDonated;

  double get amountDonatedToOrg => _amountDonatedToOrg;
}
