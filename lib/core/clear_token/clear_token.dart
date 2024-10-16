import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';
import 'package:shorts/firebase_helper.dart';

abstract class ClearToken {
  const ClearToken();

  static Future<void> clearToken({
    required String userId,
    required String fcmToken,
    required FirebaseHelperManager firebaseHelper,
  }) async {
    await _videosComments(userId, fcmToken);

    await _usersFavourites(
      userId: userId,
      fcmToken: fcmToken,
      firebaseHelper: firebaseHelper,
    );

    await _usersVideos(
      userId: userId,
      fcmToken: fcmToken,
      firebaseHelper: firebaseHelper,
    );

    await _videosCollection(
      userId: userId,
      fcmToken: fcmToken,
      firebaseHelper: firebaseHelper,
    );

    await _usersCommentsCollection(userId, fcmToken);
  }

  static Future<void> _usersCommentsCollection(
      String userId, String fcmToken) async {
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userId)
        .collection(CollectionNames.videos)
        .get()
        .then((videosQuerySnapshot) {
      for (var videoDoc in videosQuerySnapshot.docs) {
        videoDoc.reference
            .collection(CollectionNames.comments)
            .where('user.id', isEqualTo: userId)
            .get()
            .then((commentsQuerySnapshot) {
          for (var commentDoc in commentsQuerySnapshot.docs) {
            commentDoc.reference.update({'user.fcmToken': fcmToken });
          }
        });
      }
    });
  }

  static Future<void> _videosCollection({
    required String userId,
    required String fcmToken,
    required FirebaseHelperManager firebaseHelper,
  }) async {
    // Fetch videos where 'user.id' is equal to the provided userId
    List<Map<String, dynamic>> videoDocs =
        await firebaseHelper.getCollectionDocuments(
      collectionPath: CollectionNames.videos,
      whereField: 'user.id',
      whereValue: userId,
    );

    // Loop through each video document and update the fcmToken
    for (var videoDoc in videoDocs) {
      String videoId = videoDoc['id']; // Assuming 'id' is the document ID field

      // Update the fcmToken for the video
      await firebaseHelper.updateDocument(
        collectionPath: CollectionNames.videos,
        docId: videoId,
        data: {'user.fcmToken': fcmToken },
      );
    }
  }
static Future<void> _usersVideos({
  required String userId,
  required String fcmToken,
  required FirebaseHelperManager firebaseHelper,
}) async {
  // Fetch videos from the user's video collection
  List<Map<String, dynamic>> videoDocs = await firebaseHelper.getCollectionDocuments(
    collectionPath: CollectionNames.users,
    docId: userId,
    subCollectionPath: CollectionNames.videos,
  );

  // Loop through each video document and update the fcmToken
  for (var videoDoc in videoDocs) {
    String videoId = videoDoc['id']; // Assuming 'id' is the document ID field

    // Update the fcmToken for the video
    await firebaseHelper.updateDocument(
      collectionPath: CollectionNames.users,
      docId: userId,
      subCollectionPath: CollectionNames.videos,
      subDocId: videoId,
      data: {'user.fcmToken': fcmToken},
    );
  }
}


  static Future<void> _usersFavourites({
  required String userId,
  required String fcmToken,
  required FirebaseHelperManager firebaseHelper,
}) async {
  // Fetch favorites from the user's favorites collection
  List<Map<String, dynamic>> favoritesDocs = await firebaseHelper.getCollectionDocuments(
    collectionPath: CollectionNames.users,
    docId: userId,
    subCollectionPath: CollectionNames.favourites,
  );

  // Loop through each favorite document and update the fcmToken
  for (var favoriteDoc in favoritesDocs) {
    String favoriteId = favoriteDoc['id']; // Assuming 'id' is the document ID field

    // Update the fcmToken for the favorite
    await firebaseHelper.updateDocument(
      collectionPath: CollectionNames.users,
      docId: userId,
      subCollectionPath: CollectionNames.favourites,
      subDocId: favoriteId,
      data: {'user.fcmToken': fcmToken},
    );
  }
}


  static Future<void> _videosComments(String userId, String fcmToken) async {
    await FirebaseFirestore.instance
        .collection(CollectionNames.videos)
        .where('user.id', isEqualTo: userId)
        .get()
        .then((videoQuerySnapshot) {
      for (var videoDoc in videoQuerySnapshot.docs) {
        videoDoc.reference
            .collection(CollectionNames.comments)
            .where('user.id', isEqualTo: userId)
            .get()
            .then((commentsQuerySnapshot) {
          for (var commentDoc in commentsQuerySnapshot.docs) {
            commentDoc.reference.update({'user.fcmToken': fcmToken ?? ''});
          }
        });
      }
    });
  }

  // static Future<void> _usersComments(String userId, String fcmToken) async {
  //   await FirebaseFirestore.instance
  //       .collection(CollectionNames.users)
  //       .doc(userId)
  //       .collection(CollectionNames.videos)
  //       .get()
  //       .then((videosQuerySnapshot) {
  //     for (var videoDoc in videosQuerySnapshot.docs) {
  //       videoDoc.reference
  //           .collection(CollectionNames.comments)
  //           .get()
  //           .then((commentsQuerySnapshot) {
  //         for (var commentDoc in commentsQuerySnapshot.docs) {
  //           if (commentDoc.data()['user.id'] == userId) {
  //             commentDoc.reference.update({'user.fcmToken': fcmToken ?? ''});
  //           }
  //         }
  //       });
  //     }
  //   });
  // }
}
