import 'package:flutter/cupertino.dart';

class AppAccount {
  final double roundUpAmount;
  final double monthlyAddOn;
  final double maxMonthlyAddOn;

  AppAccount({
    @required this.roundUpAmount,
    @required this.monthlyAddOn,
    @required this.maxMonthlyAddOn,
  });

  // double get getRoundUpAmount => roundUpAmount;
  // double get getMonthlyAddOn => monthlyAddOn;
  // double get getMaxMonthlyAddOn => maxMonthlyAddOn;
  //
  // set setRoundUpAmount(double amount) => roundUpAmount = amount;
  // set setMonthlyAddOn(double amount) => monthlyAddOn = amount;
  // set setMaxMonthlyAddOn(double amount) => maxMonthlyAddOn = amount;
}
