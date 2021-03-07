class Transaction {
  DateTime _transactionDate;
  String _description;
  double _price;
  double _roundUpAmount;

  Transaction(this._transactionDate, this._description, this._price,
      this._roundUpAmount);

  DateTime get transactionDate => _transactionDate;
  String get description => _description;
  double get price => _price;
  double get roundUpAmount => _roundUpAmount;

  set addRoundUpAmountToOrg(double value) => _roundUpAmount = value;
}
