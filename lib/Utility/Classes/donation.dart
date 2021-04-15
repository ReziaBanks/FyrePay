import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Misc/extension.dart';


/// AppDonation Class
///
/// This class holds data for all donations gotten from Firebase
class AppDonation {
  /// AppDonation ID to differentiate objects
  final String uid;
  final String userId;
  final AppOrganization organization;
  final double cost;
  final double roundUp;
  final String description;
  final DateTime dateCreated;

  AppDonation({
    required this.uid,
    required this.userId,
    required this.cost,
    required this.roundUp,
    required this.description,
    required this.dateCreated,
    required this.organization,
  });
}

/// AppOrganizationDonation

class AppOrganizationDonation {
  final AppOrganization organization;
  final List<AppDonation> donations;

  double get totalDonation{
    double total = 0;
    for(AppDonation donation in donations){
      total = total + donation.roundUp;
    }
    return total.toPrecision(2);
  }

  AppOrganizationDonation({
    required this.organization,
    required this.donations
});
}