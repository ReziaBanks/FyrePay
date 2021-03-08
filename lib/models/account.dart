class Account {
  double roundUpAmount;
  double monthlyAddOn;
  double maxMonthlyAddOn;

  Account({this.roundUpAmount, this.monthlyAddOn, this.maxMonthlyAddOn});

  double get getRoundUpAmount => roundUpAmount;
  double get getMonthlyAddOn => monthlyAddOn;
  double get getMaxMonthlyAddOn => maxMonthlyAddOn;

  set setRoundUpAmount(double amount) => roundUpAmount = amount;
  set setMonthlyAddOn(double amount) => monthlyAddOn = amount;
  set setMaxMonthlyAddOn(double amount) => maxMonthlyAddOn = amount;
}
