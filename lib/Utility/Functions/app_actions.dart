import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_document_to_class.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';

class AppActions {

  static void getDonations(AppProvider appProvider) async{
    List<AppDonation> donationList = [];
    User user = FirebaseApi().getCurrentUser();
    if(user == null){
      print('User is empty');
      return;
    }
    List<DocumentSnapshot> donationDocSnapshot = await FirebaseApi().getDonationFilteredByUserId('${user?.uid}');

    for(DocumentSnapshot snapshot in donationDocSnapshot){
      try {
        String organizationId = snapshot.data()['organization_id'];
        DocumentSnapshot organizationSnapshot = await FirebaseApi().getDocumentByID(kOrganizationId, organizationId);
        AppDonation donation = FirebaseDocumentToClass().getDonation(snapshot, organizationSnapshot);
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

  static void getUser(AppProvider appProvider) async{
    AppUser appUser;
    User user = FirebaseApi().getCurrentUser();
    if(user == null){
      print('User is empty');
      return;
    }
    DocumentSnapshot userSnapshot = await FirebaseApi().getDocumentByID(kUserId, '${user.uid}');
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

  static Future<void> getOrganizations(AppProvider appProvider) async{
    List<AppOrganization> organizationList = [];
    List<DocumentSnapshot> organizationDocSnapshot = await FirebaseApi().getCollectionByID(kOrganizationId);

    for(DocumentSnapshot snapshot in organizationDocSnapshot){
      try {
        AppOrganization organization = FirebaseDocumentToClass().getOrganization(snapshot);
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

  static void getManagedOrganizations(AppProvider appProvider) async{
    List<AppManagedOrganization> managedOrganizationList = [];
    await getOrganizations(appProvider);
    List<AppOrganization> organizationList = appProvider.organizationList;
    User user = FirebaseApi().getCurrentUser();
    if(user == null){
      print('User is empty');
      return;
    }
    List<DocumentSnapshot> managedOrganizationSnapshot = await FirebaseApi().getManagedOrganization('${user?.uid}');
    for(DocumentSnapshot snapshot in managedOrganizationSnapshot){
      try {
        AppManagedOrganization managedOrganization = FirebaseDocumentToClass().getManagedOrganization(snapshot, organizationList);
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