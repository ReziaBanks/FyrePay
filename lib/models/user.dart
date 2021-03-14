import 'package:green_apple_pay/models/bank.dart';
import 'package:green_apple_pay/models/organization.dart';

class User {
  String email;
  String password;
  List<AppOrganization> organizations;
  List<Bank> bankInstitutions;

  User({this.email, this.password, this.organizations, this.bankInstitutions});

  String get getEmail => email;
  String get getPassword => password;
  List get getOrganizations => organizations;
  List get getBankInstitutions => bankInstitutions;

  set setEmail(String newEmail) => email = newEmail;

  set setPassword(String newPassword) => password = newPassword;

  set addOrganization(AppOrganization org) => organizations.add(org);

  set addBankInstitution(Bank account) => bankInstitutions.add(account);

  set deleteOrganization(AppOrganization org) {
    if (organizations.isNotEmpty && organizations.contains(org)) {
      organizations.remove(org);
    }
  }

  set deleteBankInstitution(Bank bank) {
    if (bankInstitutions.isNotEmpty && bankInstitutions.contains(bank)) {
      bankInstitutions.remove(bank);
    }
  }
}
