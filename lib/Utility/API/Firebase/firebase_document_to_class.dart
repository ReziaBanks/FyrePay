import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';

class FirebaseDocumentToClass {
  AppOrganization getOrganization(DocumentSnapshot organizationSnapshot) {
    String uid = organizationSnapshot.id;
    Map<String, dynamic> organizationMap = organizationSnapshot.data();

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

  AppUser getUser(DocumentSnapshot userSnapshot){
    String uid = userSnapshot.id;
    Map<String, dynamic> userMap = userSnapshot.data();

    String email = userMap['email'];
    dynamic roundUpAmount = userMap['round_up_amount'];
    dynamic monthlyAddOn = userMap['monthly_add_on'];
    dynamic maxMonthlyDonation = userMap['max_monthly_donation'];

    AppUserSettings settings = AppUserSettings(
      roundUpAmount: roundUpAmount?.toDouble(),
      monthlyAddOn: monthlyAddOn?.toDouble(),
      maxMonthlyDonation: maxMonthlyDonation?.toDouble(),
    );

    AppUser user = AppUser(
      uid: uid,
      email: email,
      settings: settings,
    );
    return user;
  }

  AppManagedOrganization getManagedOrganization(DocumentSnapshot managedOrganizationSnapshot, List<AppOrganization> organizationList){
    String uid = managedOrganizationSnapshot.id;
    Map<String, dynamic> managedOrganizationMap = managedOrganizationSnapshot.data();

    bool status = managedOrganizationMap['status'];
    String organizationId = managedOrganizationMap['organization_id'];
    double percent = managedOrganizationMap['percent'].toDouble();

    AppOrganization organization = organizationList.firstWhere((organization) => organization.uid == organizationId, orElse: () => null);
    if(organization == null){
      print('Organization Is Empty');
      return null;
    }

    AppManagedOrganization managedOrganization = AppManagedOrganization(
      uid: uid,
      organization: organization,
      status: status,
      percent: percent,
    );
    return managedOrganization;
  }

  AppDonation getDonation(DocumentSnapshot donationSnapshot, DocumentSnapshot organizationSnapshot){
    String uid = donationSnapshot.id;
    Map<String, dynamic> donationMap = donationSnapshot.data();

    String userId = donationMap['user_id'];
    double cost = donationMap['cost']?.toDouble();
    double roundUp = donationMap['round_up']?.toDouble();
    String description = donationMap['description'];
    Timestamp dateCreatedAsTimestamp = donationMap['date_created'];
    DateTime dateCreated = dateCreatedAsTimestamp.toDate();

    AppOrganization organization = getOrganization(organizationSnapshot);

    // Todo: Ensure no null value exist

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
}
