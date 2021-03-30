import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

  User getCurrentUser() {
    User currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  Future<void> logOutUser() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: '$email');
  }

  Future<void> updateEmail(String email) async{
    User currentUser = _firebaseAuth.currentUser;
    if(currentUser != null) {
      await currentUser.updateEmail('$email');
    }
  }

  Future<void> updatePassword(String newPassword) async{
    User currentUser = _firebaseAuth.currentUser;
    if(currentUser != null){
      await currentUser.updatePassword(newPassword);
    }
  }

  Future<void> sendVerificationEmail() async{
    User currentUser = _firebaseAuth.currentUser;
    if(currentUser != null){
      await currentUser.sendEmailVerification();
    }
  }

  void listenToUserChanges(Function action) async{
    _firebaseAuth.userChanges().listen((User user) {
      action(user);
    });
  }

  // Cloud Firestore

  // Read Data
  Future<DocumentSnapshot> getSceneByID(String sceneId) async {
    DocumentSnapshot sceneDocument =
        await _firebaseFirestore.collection('Scenes').doc('$sceneId').get();
    return sceneDocument;
  }

  Future<DocumentSnapshot> getStoryByID(String storyId) async {
    DocumentSnapshot storyDocument =
        await _firebaseFirestore.collection('Stories').doc('$storyId').get();
    return storyDocument;
  }

  Future<List<DocumentSnapshot>> getDocumentsByID(String collectionId) async {
    QuerySnapshot snapshot = await _firebaseFirestore.collection('$collectionId')
        // .where('status', isEqualTo: 'active')
        .get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    return documents;
  }

  Future<List<DocumentSnapshot>> getAllDocumentsById(String id) async {
    QuerySnapshot storySnapshot = await _firebaseFirestore.collection('$id').where('status', isEqualTo: 'active').get();
    List<QueryDocumentSnapshot> storyDocuments = storySnapshot.docs;
    return storyDocuments;
  }

  Future<DocumentSnapshot> getSavedDataByStoryId(
      String userId, String storyId) async {
    QuerySnapshot savedSnapshot = await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('SavedStories')
        .where('story_id', isEqualTo: '$storyId')
        .get();
    List<QueryDocumentSnapshot> savedDocumentList = savedSnapshot.docs;
    if (savedDocumentList.isNotEmpty) {
      return savedDocumentList.first;
    } else {
      return null;
    }
  }

  Future<DocumentSnapshot> getFinishedDataByStoryId(
      String userId, String storyId) async {
    QuerySnapshot finishedSnapshot = await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('FinishedStories')
        .where('story_id', isEqualTo: '$storyId')
        .get();
    List<QueryDocumentSnapshot> finishedDocumentList = finishedSnapshot.docs;
    if (finishedDocumentList.isNotEmpty) {
      return finishedDocumentList.first;
    } else {
      return null;
    }
  }

  Future<List<DocumentSnapshot>> getSavedData(String userId) async {
    QuerySnapshot savedSnapshot = await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('SavedStories')
        .get();
    return savedSnapshot.docs;
  }

  Future<List<DocumentSnapshot>> getFinishedData(String userId) async {
    QuerySnapshot finishedSnapshot = await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('FinishedStories')
        .get();
    return finishedSnapshot.docs;
  }

  // Write Data
  Future<void> saveStory(String userId, String storyId) async {
    await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('SavedStories')
        .doc()
        .set(
      {
        'date_created': FieldValue.serverTimestamp(),
        'story_id': '$storyId',
      },
      SetOptions(merge: true),
    );
  }

  Future<void> markStoryAsCompleted(String userId, String storyId) async {
    await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('FinishedStories')
        .doc()
        .set(
      {
        'date_created': FieldValue.serverTimestamp(),
        'story_id': '$storyId',
      },
      SetOptions(merge: true),
    );
  }

  // Delete Data
  Future<void> deleteStoryFromSaved(String userId, String id) async {
    await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('SavedStories')
        .doc('$id')
        .delete();
  }

  Future<void> deleteStoryFromCompleted(String userId, String id) async {
    await _firebaseFirestore
        .collection('Users')
        .doc('$userId')
        .collection('FinishedStories')
        .doc('$id')
        .delete();
  }

}
