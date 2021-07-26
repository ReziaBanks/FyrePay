import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_document_to_class.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';

/// Defines methodology to get data from the backend to apply it to the pages

class AppActions {

  // Gets all donations from the current user and updates the global donation variable
  static Future<void> getDonations(AppProvider appProvider) async{
    List<AppDonation> donationList = [];
    User? user = FirebaseApi().getCurrentUser();

    if(user == null){
      print('User is empty');
      return;
    }

    List<DocumentSnapshot> donationDocSnapshot = await FirebaseApi().getDonationFilteredByUserId('${user.uid}');

    for(DocumentSnapshot snapshot in donationDocSnapshot){
      try {
        Map<String, dynamic>? donationMap = snapshot.data()  as Map<String, dynamic>?;
        if(donationMap == null){
          print('Null Donation Map');
          break;
        }
        String organizationId = donationMap['organization_id'];
        DocumentSnapshot organizationSnapshot = await FirebaseApi().getDocumentByID(kOrganizationId, organizationId);
        AppDonation? donation = FirebaseDocumentToClass().getDonation(snapshot, organizationSnapshot);
        if(donation != null) {
          donationList.add(donation);
        }
      }
      catch(e){
        print(e);
      }
    }
    appProvider.updateDonationList(donationList);
  }

  // Updates the current user's information
  static Future<void> getUser(AppProvider appProvider) async{
    AppUser? appUser;
    User? user = FirebaseApi().getCurrentUser();
    if(user == null){
      print('User is empty');
      return;
    }
    DocumentSnapshot userSnapshot = await FirebaseApi().getDocumentByID(kUserId, user.uid);
    try{
      appUser = FirebaseDocumentToClass().getUser(userSnapshot);
      if(appUser != null){
        appProvider.updateAppUser(appUser);
      }
      else{
        print('User is null');
      }
    }
    catch(e){
      print(e);
    }
  }

  // Updates the organization list data
  static Future<void> getOrganizations(AppProvider appProvider) async{
    List<AppOrganization> organizationList = [];
    List<DocumentSnapshot> organizationDocSnapshot = await FirebaseApi().getCollectionByID(kOrganizationId);

    for(DocumentSnapshot snapshot in organizationDocSnapshot){
      try {
        AppOrganization? organization = FirebaseDocumentToClass().getOrganization(snapshot);
        if(organization != null) {
          organizationList.add(organization);
        }
      }
      catch(e){
        print(e);
      }
    }
    appProvider.updateOrganizationList(organizationList);
  }

  // Updates the percentage-based listings in the Managed Organization page
  static Future<void> getManagedOrganizations(AppProvider appProvider) async{
    List<AppManagedOrganization> managedOrganizationList = [];
    await getOrganizations(appProvider);
    List<AppOrganization>? organizationList = appProvider.organizationList;
    if(organizationList == null){
      print('An Error Occurred');
      return;
    }
    User? user = FirebaseApi().getCurrentUser();
    if(user == null){
      print('User is empty');
      return;
    }
    List<DocumentSnapshot> managedOrganizationSnapshot = await FirebaseApi().getManagedOrganization('${user.uid}');
    for(DocumentSnapshot snapshot in managedOrganizationSnapshot){
      try {
        AppManagedOrganization? managedOrganization = FirebaseDocumentToClass().getManagedOrganization(snapshot, organizationList);
        if(managedOrganization != null) {
          managedOrganizationList.add(managedOrganization);
        }
      }
      catch(e){
        print(e);
      }
    }
    appProvider.updateManagedOrganizationList(managedOrganizationList);
  }

}