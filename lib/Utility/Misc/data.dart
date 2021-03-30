import 'package:green_apple_pay/Utility/Classes/bank.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/account.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/transaction.dart';

class AppData {
  static String defaultUrl = 'https://www.theverge.com/tech';
  static String bankConnectionText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit vel in cursus volutpat.';
  static String passwordResetText =
      'Enter your email address below, we’ll send you a verification code.';

  static String organizationDescr1 = 'Wounded Warriors Canada is a national mental health service provider utilizing clinical best practices and evidence-based care to create an environment of compassion, resiliency and hope for Canada’s Veterans, First Responders and their families.';
  static String organizationAddress1 = '310 Byron Street South, Suite 4 Whitby, Ontario L1N 4P8';

  static String organizationImageUrl1 =
      'https://images.unsplash.com/photo-1615201427548-58316e349d8a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  static String organizationImageUrl2 =
      'https://images.unsplash.com/photo-1615146919563-70db4a72f100?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  static String organizationImageUrl3 =
      'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1490&q=80';

  static AppDonationV2 donation =
  AppDonationV2(totalAmountDonated: 100.00, amountDonatedToOrg: 50, orgId: 1);

  static AppAccount account =
  AppAccount(roundUpAmount: 1.0, monthlyAddOn: 20.0, maxMonthlyAddOn: 30.0);

  static AppBank bank =
  AppBank(institutionName: 'TD CANADA TRUST', accountNumber: 000789892);

  static AppOrganization org1 = AppOrganization(
      uid: "iduasnkanmksanmksnma",
      name: 'The Children\'s Aid Society',
      email: 'test@hamiltoncas.com',
      about:
      'We continue to provide core child protection services, with a focus on keeping children and youth safe.',
      website: 'https://www.hamiltoncas.com/',
      address: '735 King Street East',
      city: 'Hamilton',
      province: 'Ontario',
      postalCode: 'L8M 1A1',
      allocation: 0,
      isActive: false,
      lifeTimeDonation: 20.0,
      imageURL: organizationImageUrl1);

  static AppOrganization org2 = AppOrganization(
      uid: 'askansjasnjaknsjoa',
      name: 'Sick Kids Foundation',
      email: 'test@test.com',
      about:
      'We continue to provide core child protection services, with a focus on keeping children and youth safe.',
      website: 'https://www.SickKidsFoundation.com/',
      address: '222 King Street East',
      city: 'Hamilton',
      province: 'Ontario',
      postalCode: 'L8M 3A3',
      allocation: 0,
      isActive: false,
      lifeTimeDonation: 30.0,
      imageURL: organizationImageUrl2);

  static Transaction transaction = Transaction(
      transactionDate: DateTime.now(),
      description: 'Uber Eats',
      price: 23.34,
      roundUpAmount: 66);

  static List<AppOrganization> orgs = [org1, org2];
  static List<AppBank> banks = [bank];

  AppUser testUser = AppUser(
      uid: 'skansjansikoanslajksa',
      email: 'test@test.com',
      organizations: orgs,
      bankInstitutions: banks);
}
