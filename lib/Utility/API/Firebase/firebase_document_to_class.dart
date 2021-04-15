import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';

/// A class that represents methods to connect the database data to instanced objects

class FirebaseDocumentToClass {

  // Creates an organization object with its name, email, about, website, address, and email
  AppOrganization? getOrganization(DocumentSnapshot organizationSnapshot) {
    String uid = organizationSnapshot.id;
    Map<String, dynamic>? organizationMap = organizationSnapshot.data();

    if(organizationMap != null) {
      String name = organizationMap['name'];
      String email = organizationMap['email'];
      String about = organizationMap['about'];
      String website = organizationMap['website'];
      String address = organizationMap['address'];
      String imageURL = organizationMap['image'];

      AppOrganization organization = AppOrganization(
        uid: uid,
        name: name,
        email: email,
        about: about,
        website: website,
        address: address,
        imageURL: imageURL,
      );
      return organization;
    }
    else return null;
  }

  // Gets a user donation
  AppDonation? getDonation(DocumentSnapshot donationSnapshot, DocumentSnapshot organizationSnapshot){
    String uid = donationSnapshot.id;
    Map<String, dynamic>? donationMap = donationSnapshot.data();

    if(donationMap != null) {
      String userId = donationMap['user_id'];
      double cost = donationMap['cost'].toDouble();
      double roundUp = donationMap['round_up'].toDouble();
      String description = donationMap['description'];
      Timestamp dateCreatedAsTimestamp = donationMap['date_created'];
      DateTime dateCreated = dateCreatedAsTimestamp.toDate();

      AppOrganization? organization = getOrganization(organizationSnapshot);

      if (organization != null) {
        AppDonation donation = AppDonation(
          uid: uid,
          userId: userId,
          cost: cost,
          organization: organization,
          roundUp: roundUp,
          description: description,
          dateCreated: dateCreated,
        );
        return donation;
      }
      else
        return null;
    }
    else return null;
  }

  // Gets the user information, including their settings
  AppUser? getUser(DocumentSnapshot userSnapshot){
    String uid = userSnapshot.id;
    Map<String, dynamic>? userMap = userSnapshot.data();

    if(userMap != null) {
      String? email = userMap['email'];
      double roundUpAmount = userMap['round_up_amount'].toDouble();
      double monthlyAddOn = userMap['monthly_add_on'].toDouble();
      double maxMonthlyDonation = userMap['max_monthly_donation'].toDouble();

      AppUserSettings settings = AppUserSettings(
        roundUpAmount: roundUpAmount,
        monthlyAddOn: monthlyAddOn,
        maxMonthlyDonation: maxMonthlyDonation,
      );

      AppUser user = AppUser(
        uid: uid,
        email: email,
        settings: settings,
      );
      return user;
    }
    else return null;
  }

  // Gets the organization, organization percentage, and whether its active or not
  AppManagedOrganization? getManagedOrganization(DocumentSnapshot managedOrganizationSnapshot, List<AppOrganization> organizationList){
    String uid = managedOrganizationSnapshot.id;
    Map<String, dynamic>? managedOrganizationMap = managedOrganizationSnapshot.data();

    if(managedOrganizationMap != null) {
      bool status = managedOrganizationMap['status'];
      String organizationId = managedOrganizationMap['organization_id'];
      double percent = managedOrganizationMap['percent'].toDouble();

      AppOrganization? organization = organizationList.firstWhereOrNull((organization) => organization.uid == organizationId);

      if (organization == null) {
        throw 'Organization not found';
      }

      AppManagedOrganization managedOrganization = AppManagedOrganization(
        uid: uid,
        organization: organization,
        status: status,
        percent: percent,
      );
      return managedOrganization;
    }
    else return null;
  }

}
