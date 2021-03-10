class Transaction {
  DateTime transactionDate;
  String description;
  double price;
  double roundUpAmount;

  Transaction(
      {this.transactionDate, this.description, this.price, this.roundUpAmount});

  DateTime get getTransactionDate => transactionDate;
  String get getDescription => description;
  double get getPrice => price;
  double get getRoundUpAmount => roundUpAmount;

  set addRoundUpAmountToOrg(double value) => roundUpAmount = value;
}
