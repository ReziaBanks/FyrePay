import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_apple_pay/Utility/Classes/user.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class FirebaseApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User getCurrentUser() {
    User currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  // Firebase Auth
  Future<User> signUpWithEmailAndPassword(
      {String email, String password}) async {
    UserCredential userCredentials = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredentials != null) {
      await _firebaseFirestore
          .collection('Users')
          .doc('${userCredentials.user.uid}')
          .set({
        'email_address': userCredentials.user.email,
        'uid': userCredentials.user.uid,
        'round_up_amount': 1,
      }, SetOptions(merge: true));
      return userCredentials.user;
    } else
      return null;
  }

  Future<User> signInWithEmailAndPassword(
      {String email, String password}) async {
    UserCredential userCredentials = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredentials != null) {
      return userCredentials.user;
    } else
      return null;
  }

  Future<void> logOutUser() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: '$email');
  }

  Future<void> updateEmail(String email) async {
    User currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.updateEmail('$email');
    }
  }

  Future<void> updatePassword(String newPassword) async {
    User currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.updatePassword(newPassword);
    }
  }

  Future<bool> validatePassword(String password) async {
    User currentUser = _firebaseAuth.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: currentUser.email, password: password);
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

  Future<void> sendVerificationEmail() async {
    User currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await currentUser.sendEmailVerification();
    }
  }

  void listenToUserChanges(Function action) async {
    _firebaseAuth.userChanges().listen((User user) {
      action(user);
    });
  }

  // Cloud Firestore

  // GET
  Future<List<DocumentSnapshot>> getCollectionByID(String collectionId) async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection('$collectionId').get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }

  Future<List<DocumentSnapshot>> getManagedOrganization(String userId) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection('$kUserId')
        .doc('$userId')
        .collection('$kManagedOrganizationId')
        .get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }

  Future<List<DocumentSnapshot>> getDonationFilteredByUserId(
      String userId) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(kDonationId)
        .where('user_id', isEqualTo: userId)
        .get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }

  Future<DocumentSnapshot> getDocumentByID(
      String collectionId, String documentId) async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection('$collectionId')
        .doc('$documentId')
        .get();
    return snapshot;
  }

  // UPDATE / POST
  Future<void> updateUserDocument(String userId, Map<String, dynamic> data) async {
    await _firebaseFirestore.collection('$kUserId')
        .doc('$userId')
        .set(data, SetOptions(merge: true));
  }

  Future<void> addDonation(Map<String, dynamic> data) async{
    await _firebaseFirestore.collection('$kDonationId')
        .doc()
        .set(data, SetOptions(merge: true));
  }

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
