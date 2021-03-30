import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_api.dart';
import 'package:green_apple_pay/Utility/API/Firebase/firebase_document_to_class.dart';
import 'package:green_apple_pay/Utility/Classes/donation.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';
import 'package:green_apple_pay/Utility/Providers/app_provider.dart';

class AppActions {

  static void getDonations(AppProvider appProvider) async{
    List<AppDonation> donationList = [];
    List<DocumentSnapshot> donationDocSnapshot = await FirebaseApi().getDocumentsByID(kDonationId);

    for(DocumentSnapshot snapshot in donationDocSnapshot){
      try {
        AppDonation donation = FirebaseDocumentToClass().getDonation(snapshot);
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

  static void getOrganizations(AppProvider appProvider) async{
    List<AppOrganization> organizationList = [];
    List<DocumentSnapshot> organizationDocSnapshot = await FirebaseApi().getDocumentsByID(kOrganizationId);

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

}