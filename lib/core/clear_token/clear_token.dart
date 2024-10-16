import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';

abstract class ClearToken {
  const ClearToken();

  static Future<void> clearToken({
    required String userId,
  required  String fcmToken,
  }) async {

    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userId)
        .collection(CollectionNames.videos)
        .get()
        .then((videosQuerySnapshot) {
      for (var videoDoc in videosQuerySnapshot.docs) {
        videoDoc.reference
            .collection(CollectionNames.comments)
            .get()
            .then((commentsQuerySnapshot) {
          for (var commentDoc in commentsQuerySnapshot.docs) {
            if (commentDoc.data()['user.id'] == userId) {
              commentDoc.reference.update({'user.fcmToken': fcmToken ?? ''});
            }
          }
        });
      }
    });


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


    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userId)
        .collection(CollectionNames.favourites)
        .get()
        .then((favoritesQuerySnapshot) {
      for (var favoriteDoc in favoritesQuerySnapshot.docs) {
        favoriteDoc.reference.update({'user.fcmToken': fcmToken ?? ''});
      }
    });


    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userId)
        .collection(CollectionNames.videos)
        .get()
        .then((videoQuerySnapshot) {
      for (var videoDoc in videoQuerySnapshot.docs) {
        videoDoc.reference.update({'user.fcmToken': fcmToken ?? ''});
      }
    });


    await FirebaseFirestore.instance
        .collection(CollectionNames.videos)
        .where('user.id', isEqualTo: userId)
        .get()
        .then((videoQuerySnapshot) {
      for (var videoDoc in videoQuerySnapshot.docs) {
        videoDoc.reference.update({'user.fcmToken': fcmToken ?? ''});
      }
    });


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
            commentDoc.reference.update({'user.fcmToken': fcmToken ?? ''});
          }
        });
      }
    });
  }
  }



