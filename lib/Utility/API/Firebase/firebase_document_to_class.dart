import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_apple_pay/Utility/Classes/organization.dart';

class FirebaseDocumentToClass {
  // AppStory getStory(DocumentSnapshot storySnapshot, List<DocumentSnapshot> sceneSnapshotList) {
  //   String id = storySnapshot.id;
  //   Map<String, dynamic> storyMap = storySnapshot.data();
  //
  //   String title = storyMap['title'];
  //   String description = storyMap['description'];
  //   List<String> keywords = List<String>.from(storyMap['keywords']);
  //   String categoryAsString = storyMap['category'];
  //   AppStoryCategory category = AppFunctions.convertStringToAppCategory('$categoryAsString');
  //
  //   Map<String, dynamic> imageMap = storyMap['image'];
  //   Map<String, dynamic> featuredImageMap = storyMap['featured_image'];
  //
  //   AppMediaContent image = AppMediaContent(
  //     url: '${imageMap['url']}',
  //     location: '${imageMap['location']}',
  //   );
  //
  //   AppMediaContent featuredImage = AppMediaContent(
  //     url: '${featuredImageMap['url']}',
  //     location: '${featuredImageMap['location']}',
  //   );
  //
  //   List<AppStoryScene> scenes = [];
  //   for (DocumentSnapshot snapshot in sceneSnapshotList) {
  //     AppStoryScene scene = getStoryScene(snapshot);
  //     scenes.add(scene);
  //   }
  //
  //   AppStory story = AppStory(
  //     id: id,
  //     title: title,
  //     image: image,
  //     featuredImage: featuredImage,
  //     description: description,
  //     category: category,
  //     scenes: scenes,
  //     keywords: keywords,
  //   );
  //   if(scenes.isNotEmpty){
  //     return story;
  //   }
  //   else{
  //     return null;
  //   }
  // }
  //
  // AppStoryScene getStoryScene(DocumentSnapshot sceneSnapshot) {
  //   String sceneId = sceneSnapshot.id;
  //   Map<String, dynamic> sceneMap = sceneSnapshot.data();
  //
  //   Map<String, dynamic> text = sceneMap['text'];
  //   Map<String, dynamic> audio = sceneMap['audio'];
  //
  //   String textUrl = text['url'];
  //   String textLocation = text['location'];
  //   String audioUrl = audio['url'];
  //   String audioLocation = audio['location'];
  //
  //   AppMediaContent sceneText = AppMediaContent(
  //     url: '$textUrl',
  //     location: '$textLocation',
  //   );
  //
  //   AppMediaContent sceneAudio = AppMediaContent(
  //     url: '$audioUrl',
  //     location: '$audioLocation',
  //   );
  //
  //   AppStoryScene scene = AppStoryScene(
  //     id: '$sceneId',
  //     sceneText: sceneText,
  //     sceneAudio: sceneAudio,
  //   );
  //
  //   return scene;
  // }
  //
  // AppPlayList getPlayList(DocumentSnapshot playListSnapshot, List<DocumentSnapshot> storiesSnapshotList, List<DocumentSnapshot> scenesSnapshotList){
  //   String uid = playListSnapshot.id;
  //   Map<String, dynamic> playListMap = playListSnapshot.data();
  //
  //   if(playListMap != null){
  //     String title = playListMap['title'];
  //     Timestamp dateCreatedStamp = playListMap['date_created'];
  //     Timestamp dateModifiedStamp = playListMap['date_modified'];
  //     String statusString = playListMap['status'];
  //     String typeString = playListMap['type'];
  //     bool isFeatured = playListMap['is_featured'];
  //     List<dynamic> storyIdList = playListMap['story_list'];
  //     List<AppStory> stories = [];
  //     List<DocumentSnapshot> filteredStoriesSnapshotList = storiesSnapshotList.where((storySnapshot) => storyIdList.contains(storySnapshot.id)).toList();
  //
  //     for(DocumentSnapshot storySnapshot in filteredStoriesSnapshotList){
  //       Map<String, dynamic> storyMap = storySnapshot.data();
  //       if(storyMap != null) {
  //         List<dynamic> sceneIdList = storyMap['scenes'];
  //         List<DocumentSnapshot> filteredSceneSnapshotList = scenesSnapshotList.where((sceneSnapshot) => sceneIdList.contains(sceneSnapshot.id)).toList();
  //         AppStory story = getStory(storySnapshot, filteredSceneSnapshotList);
  //         if(story != null){
  //           stories.add(story);
  //         }
  //       }
  //     }
  //
  //     AppStatus status = AppFunctions.convertStringToStatus(statusString);
  //     AppPlayListType type = AppFunctions.convertStringToPlayListType(typeString);
  //
  //     if(status != null) {
  //       AppManualPlayList playList = AppManualPlayList(
  //         uid: uid,
  //         title: title,
  //         status: status,
  //         dateCreated: dateCreatedStamp.toDate(),
  //         dateModified: dateModifiedStamp.toDate(),
  //         isFeatured: isFeatured != null ? isFeatured : false,
  //         storyList: stories,
  //       );
  //       if(playList?.storyList?.isNotEmpty == true){
  //         return playList;
  //       }
  //       else{
  //         return null;
  //       }
  //     }
  //     else return null;
  //   }
  //   else{
  //     return null;
  //   }
  // }

  AppOrganization getOrganization(DocumentSnapshot organizationSnapshot) {
    String uid = organizationSnapshot.id;
    Map<String, dynamic> organizationMap = organizationSnapshot.data();

    String name = organizationMap['name'];
    String email = organizationMap['email'];
    String about = organizationMap['about'];
    String website = organizationMap['website'];
    String address = organizationMap['address'];
    String imageURL = organizationMap['image'];

    AppOrganization organization =AppOrganization(
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
}
