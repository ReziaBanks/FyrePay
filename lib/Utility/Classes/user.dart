import 'package:flutter/cupertino.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'bank.dart';

class AppUser {
  final String uid;
  final String email;
  List<AppOrganization> organizations;
  List<AppBank> bankInstitutions;

  AppUser({
    @required this.uid,
    @required this.email,
    this.organizations,
    this.bankInstitutions,
  });

  set addOrganization(AppOrganization org) => organizations.add(org);

  set addBankInstitution(AppBank account) => bankInstitutions.add(account);

  set deleteOrganization(AppOrganization org) {
    if (organizations.isNotEmpty && organizations.contains(org)) {
      organizations.remove(org);
    }
  }

  set deleteBankInstitution(AppBank bank) {
    if (bankInstitutions.isNotEmpty && bankInstitutions.contains(bank)) {
      bankInstitutions.remove(bank);
    }
  }
}
