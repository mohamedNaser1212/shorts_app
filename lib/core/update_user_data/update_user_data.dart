import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shorts/Features/profile_feature.dart/domain/update_model/update_request_model.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

abstract class UpdateUserData {
  const UpdateUserData._();

  static Future<void> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
    required FirebaseHelper firebaseHelper,
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) async {
    await _usersVideos(
      userId: userId,
      updateUserRequestModel: updateUserRequestModel,
      firebaseHelper: firebaseHelper,
    );
    await _videosCollectionComments(
      userId: userId,
      updateUserRequestModel: updateUserRequestModel,
      firestore: firestore,
    );
    await _videosCollection(
      userId: userId,
      updateUserRequestModel: updateUserRequestModel,
      firebaseHelper: firebaseHelper,
    );
    await _usersFavourites(
      userId: userId,
      updateUserRequestModel: updateUserRequestModel,
      firebaseHelper: firebaseHelper,
    );
    await _usersComments(
      userId: userId,
      updateUserRequestModel: updateUserRequestModel,
      firestore: firestore,
    );

    await _updateUserCollection(
      userId: userId,
      updateUserRequestModel: updateUserRequestModel,
      firebaseHelper: firebaseHelper,
    );
    await _userVideosCollectionComments(
      userId: userId,
      updateUserRequestModel: updateUserRequestModel,
      firestore: firestore,
    );
  }

  static Future<void> _updateUserCollection({
    required String userId,
    required UpdateUserRequestModel updateUserRequestModel,
    required FirebaseHelper firebaseHelper,
  }) async {
    await firebaseHelper.updateDocument(
      collectionPath: CollectionNames.users,
      docId: userId,
      data: updateUserRequestModel.toMap(),
    );
  }

  static Future<void> _usersComments({
    required String userId,
    required UpdateUserRequestModel updateUserRequestModel,
    required FirebaseFirestore firestore,
  }) async {
    await firestore
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
            _userUpdatedData(commentDoc, updateUserRequestModel);
          }
        });
      }
    });
  }

  static Future<void> _usersFavourites({
    required String userId,
    required UpdateUserRequestModel updateUserRequestModel,
    required FirebaseHelper firebaseHelper,
  }) async {
    // Fetch the user's favorite documents where the user's ID matches
    List<Map<String, dynamic>> favourites =
        await firebaseHelper.getCollectionDocuments(
      collectionPath:
          '${CollectionNames.users}/$userId/${CollectionNames.favourites}',
      whereField: 'user.id',
      whereValue: userId,
    );

    for (var favourite in favourites) {
      await firebaseHelper.updateDocument(
        collectionPath:
            '${CollectionNames.users}/$userId/${CollectionNames.favourites}',
        docId: favourite['id'],
        data: {
          'user.name': updateUserRequestModel.name,
          'user.profilePic': updateUserRequestModel.imageUrl,
          'user.email': updateUserRequestModel.email,
          'user.phone': updateUserRequestModel.phone,
        },
      );
    }
  }

  static Future<void> _videosCollectionComments({
    required String userId,
    required UpdateUserRequestModel updateUserRequestModel,
    required FirebaseFirestore firestore,
  }) async {
    final videoQuerySnapshot =
        await firestore.collection(CollectionNames.videos).get();

    for (var videoDoc in videoQuerySnapshot.docs) {
      final commentsQuerySnapshot = await videoDoc.reference
          .collection(CollectionNames.comments)
          .where('user.id', isEqualTo: userId)
          .get();
      print(commentsQuerySnapshot.docs.length);

      for (var commentDoc in commentsQuerySnapshot.docs) {
        await _userUpdatedData(commentDoc, updateUserRequestModel);
      }
    }
  }

  static Future<void> _userVideosCollectionComments({
    required String userId,
    required UpdateUserRequestModel updateUserRequestModel,
    required FirebaseFirestore firestore,
  }) async {
    await firestore
        .collection(CollectionNames.users)
        .doc(userId)
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
            _userUpdatedData(commentDoc, updateUserRequestModel);
          }
        });
      }
    });
  }

  static Future<void> _videosCollection({
    required String userId,
    required UpdateUserRequestModel updateUserRequestModel,
    required FirebaseHelper firebaseHelper,
  }) async {
    List<Map<String, dynamic>> videos =
        await firebaseHelper.getCollectionDocuments(
      collectionPath: CollectionNames.videos,
      whereField: 'user.id',
      whereValue: userId,
    );

    for (var video in videos) {
      await firebaseHelper.updateDocument(
        collectionPath: CollectionNames.videos,
        docId: video['id'],
        data: {
          'user.name': updateUserRequestModel.name,
          'user.profilePic': updateUserRequestModel.imageUrl,
          'user.email': updateUserRequestModel.email,
          'user.phone': updateUserRequestModel.phone,
        },
      );
    }
  }

  static Future<void> _usersVideos({
    required String userId,
    required UpdateUserRequestModel updateUserRequestModel,
    required FirebaseHelper firebaseHelper,
  }) async {
    List<Map<String, dynamic>> videos =
        await firebaseHelper.getCollectionDocuments(
      collectionPath:
          '${CollectionNames.users}/$userId/${CollectionNames.videos}',
    );

    for (var video in videos) {
      await firebaseHelper.updateDocument(
        collectionPath:
            '${CollectionNames.users}/$userId/${CollectionNames.videos}',
        docId: video['id'],
        data: {
          'user.name': updateUserRequestModel.name,
          'user.profilePic': updateUserRequestModel.imageUrl,
          'user.email': updateUserRequestModel.email,
          'user.phone': updateUserRequestModel.phone,
        },
      );
    }
  }

  static Future<void> _userUpdatedData(
      QueryDocumentSnapshot<Map<String, dynamic>> videoDoc,
      UpdateUserRequestModel updateUserRequestModel) {
    return videoDoc.reference.update({
      'user.name': updateUserRequestModel.name,
      'user.profilePic': updateUserRequestModel.imageUrl,
      'user.email': updateUserRequestModel.email,
      'user.phone': updateUserRequestModel.phone,
    });
  }
}
