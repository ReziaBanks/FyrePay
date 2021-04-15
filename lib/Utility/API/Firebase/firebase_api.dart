import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

// Represents the functionality that communicates between the app and the database

class FirebaseApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    User? currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  // Firebase Auth
  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredentials = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await _firebaseFirestore
        .collection('Users')
        .doc('${userCredentials.user!.uid}')
        .set({
      'email_address': userCredentials.user!.email,
      'uid': userCredentials.user!.uid,
      'round_up_amount': 1,
    }, SetOptions(merge: true));
    return userCredentials.user;
  }

  // Make a request to sign in the user with a  given email and password
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredentials = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredentials.user;
  }

  // Makes a request to log the user out
  Future<void> logOutUser() async {
    await _firebaseAuth.signOut();
  }

  // Sends a reset password email
  Future<void> sendResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: '$email');
  }

  // Makes a request to update the email to a given email
  Future<void> updateEmail(String email) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.updateEmail('$email');
    }
  }

  // Makes a request to update the user's password to a given new password
  Future<void> updatePassword(String newPassword) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.updatePassword(newPassword);
    }
  }

  // Confirms a password input with the current user's password
  Future<bool> validatePassword(String password) async {
    User currentUser = _firebaseAuth.currentUser!;

    var authCredentials = EmailAuthProvider.credential(
        email: currentUser.email!, password: password);
    try {
      var authResult =
          await currentUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } on PlatformException catch (err) {
      // Handle err
      print(err);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Makes a request to verify the user's email
  Future<void> sendVerificationEmail() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.sendEmailVerification();
    }
  }

  // Cloud Firestore

  // GET table by table id
  Future<List<DocumentSnapshot>> getCollectionByID(String collectionId) async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection('$collectionId').get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }

  // Get a list of all managed organizations by the current user
  Future<List<DocumentSnapshot>> getManagedOrganization(String userId) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection('$kUserId')
        .doc('$userId')
        .collection('$kManagedOrganizationId')
        .get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }

  // Get list of donations by the current user
  Future<List<DocumentSnapshot>> getDonationFilteredByUserId(
      String userId) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(kDonationId)
        .where('user_id', isEqualTo: userId)
        .get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }

  // Get record from table by record id and table id
  Future<DocumentSnapshot> getDocumentByID(
      String collectionId, String? documentId) async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection('$collectionId')
        .doc('$documentId')
        .get();
    return snapshot;
  }

  // UPDATE / POST

  // Updates the user record with the given user id and data to be set
  Future<void> updateUserDocument(String userId, Map<String, dynamic> data) async {
    await _firebaseFirestore.collection('$kUserId')
        .doc('$userId')
        .set(data, SetOptions(merge: true));
  }

  // Adds a transaction to the db
  Future<void> addDonation(Map<String, dynamic> data) async{
    await _firebaseFirestore.collection('$kDonationId')
        .doc()
        .set(data, SetOptions(merge: true));
  }

  // Deletes and re-adds the organizations
  Future<void> updateUserManagedOrganization(String userId, List<AppManagedOrganization> valueList, List<Map<String, dynamic>> dataList) async{
    for(AppManagedOrganization value in valueList){
      await _firebaseFirestore.collection('$kUserId')
          .doc('$userId')
          .collection('$kManagedOrganizationId')
          .doc('${value.uid}')
          .delete();
    }
    for(Map<String, dynamic> data in dataList){
      await _firebaseFirestore.collection('$kUserId')
          .doc('$userId')
          .collection('$kManagedOrganizationId')
          .doc()
          .set(data, SetOptions(merge: true));
    }
  }

  // Adds or removes organizations to the manage organization list
  Future<void> toggleUserManagedOrganization(String userId, String orgId) async{
    QuerySnapshot snapshot = await _firebaseFirestore.collection('$kUserId')
        .doc('$userId')
        .collection('$kManagedOrganizationId')
        .where('organization', isEqualTo: orgId)
        .get();
    List<DocumentSnapshot> documentList = snapshot.docs;
    if(documentList.isEmpty){
      // Add Data
      Map<String, dynamic> data = {
        'organization_id': orgId,
        'status': true,
        'percent': 0,
      };
      await _firebaseFirestore.collection('$kUserId')
          .doc('$userId')
          .collection('$kManagedOrganizationId')
          .doc()
      .set(data, SetOptions(merge: true));
    }
    else{
      // Remove All Data
      for(DocumentSnapshot doc in documentList){
        await _firebaseFirestore.collection('$kUserId')
            .doc('$userId')
            .collection('$kManagedOrganizationId')
            .doc('${doc.id}')
            .delete();
      }
    }
  }
}
