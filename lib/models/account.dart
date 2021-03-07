class Account {
  double _roundUpAmount;
  double _monthlyAddOn;
  double _maxMonthlyAddOn;

  Account(this._roundUpAmount, this._monthlyAddOn, this._maxMonthlyAddOn);

  double get roundUpAmount => _roundUpAmount;
  double get monthlyAddOn => _monthlyAddOn;
  double get maxMonthlyAddOn => _maxMonthlyAddOn;

  set setRoundUpAmount(double amount) => _roundUpAmount = amount;
  set setMonthlyAddOn(double amount) => _monthlyAddOn = amount;
  set setMaxMonthlyAddOn(double amount) => _maxMonthlyAddOn = amount;
}
