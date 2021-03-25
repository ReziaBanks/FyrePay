import 'package:flutter/foundation.dart';

class Transaction {
  final DateTime transactionDate;
  final String description;
  final double price;
  final double roundUpAmount;

  Transaction({
    @required this.transactionDate,
    @required this.description,
    @required this.price,
    @required this.roundUpAmount,
  });

  // DateTime get getTransactionDate => transactionDate;
  // String get getDescription => description;
  // double get getPrice => price;
  // double get getRoundUpAmount => roundUpAmount;
  //
  // set addRoundUpAmountToOrg(double value) => roundUpAmount = value;
}
