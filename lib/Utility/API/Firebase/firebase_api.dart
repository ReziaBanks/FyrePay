import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
        'uid': userCredentials.user.uid
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
  Future<List<DocumentSnapshot>> getDocumentsByID(
      String collectionId) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection('$collectionId')
        .get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }
}
