import 'package:green_apple_pay/models/bank.dart';
import 'package:green_apple_pay/models/organization.dart';

class User {
  String _email;
  String _password;
  List<Organization> _organizations;
  List<Bank> _bankInstitutions;

  User(this._email, this._password);

  String get email => _email;
  String get password => _password;
  List get organizations => _organizations;
  List get bankInstitutions => _bankInstitutions;

  set setEmail(String newEmail) => _email = newEmail;

  set setPassword(String newPassword) => _password = newPassword;

  set addOrganization(Organization org) => _organizations.add(org);

  set addBankInstitution(Bank account) => _bankInstitutions.add(account);

  set deleteOrganization(Organization org) {
    if (_organizations.isNotEmpty && _organizations.contains(org)) {
      _organizations.remove(org);
    }
  }

  set deleteBankInstitution(Bank bank) {
    if (_bankInstitutions.isNotEmpty && _bankInstitutions.contains(bank)) {
      _bankInstitutions.remove(bank);
    }
  }
}
