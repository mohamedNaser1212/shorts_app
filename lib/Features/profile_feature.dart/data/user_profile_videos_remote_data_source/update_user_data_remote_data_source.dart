import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';
import 'package:shorts/Features/profile_feature.dart/domain/update_model/update_request_model.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';

abstract class UpdateUserDataRemoteDataSource {
  const UpdateUserDataRemoteDataSource._();

  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  });
}

class UpdateUserDataSourceImpl implements UpdateUserDataRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  }) async {
    // Get the current user from Firebase Auth
    User? currentUser = auth.currentUser;

    if (currentUser != null) {
      // If the email is being updated, update it in Firebase Authentication
      if (updateUserRequestModel.email != currentUser.email) {
        await _updateUserEmailInAuth(
          currentUser: currentUser,
          newEmail: updateUserRequestModel.email,
        );
      }
    }

    // Update Firestore document
    await _updateUserCollection(userId, updateUserRequestModel);

    // Call functions to update all associated Firestore records
    await _usersVideos(userId, updateUserRequestModel);
    await _videosCollectionComments(userId, updateUserRequestModel);
    await _videosCollection(userId, updateUserRequestModel);
    await _usersFavourites(userId, updateUserRequestModel);
    await _usersComments(userId, updateUserRequestModel);

    DocumentSnapshot userDoc =
        await firestore.collection(CollectionNames.users).doc(userId).get();
    final userData = userDoc.data() as Map<String, dynamic>;

    return UserModel.fromJson(userData);
  }

  Future<void> _updateUserEmailInAuth({
    required User currentUser,
    required String newEmail,
  }) async {
    await currentUser.verifyBeforeUpdateEmail(newEmail);// Verify the new email
    await currentUser.reload(); // Reload user to apply the updated email
  }

  Future<void> _updateUserCollection(
      String userId, UpdateUserRequestModel updateUserRequestModel) async {
    await firestore.collection(CollectionNames.users).doc(userId).update(
          updateUserRequestModel.toMap(),
        );
  }

  Future<void> _usersComments(
      String userId, UpdateUserRequestModel updateUserRequestModel) async {
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

  Future<void> _usersFavourites(
      String userId, UpdateUserRequestModel updateUserRequestModel) async {
    await firestore
        .collection(CollectionNames.users)
        .doc(userId)
        .collection(CollectionNames.favourites)
        .where('user.id', isEqualTo: userId)
        .get()
        .then((favoritesQuerySnapshot) {
      for (var favoriteDoc in favoritesQuerySnapshot.docs) {
        _userUpdatedData(favoriteDoc, updateUserRequestModel);
      }
    });
  }

  Future<void> _videosCollectionComments(
      String userId, UpdateUserRequestModel updateUserRequestModel) async {
    await firestore
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

  Future<void> _videosCollection(
      String userId, UpdateUserRequestModel updateUserRequestModel) async {
    await firestore
        .collection(CollectionNames.videos)
        .where('user.id', isEqualTo: userId)
        .get()
        .then((videoQuerySnapshot) {
      for (var videoDoc in videoQuerySnapshot.docs) {
        _userUpdatedData(videoDoc, updateUserRequestModel);
      }
    });
  }

  Future<void> _usersVideos(
      String userId, UpdateUserRequestModel updateUserRequestModel) async {
    await firestore
        .collection(CollectionNames.users)
        .doc(userId)
        .collection(CollectionNames.videos)
        .get()
        .then((videoQuerySnapshot) {
      for (var videoDoc in videoQuerySnapshot.docs) {
        _userUpdatedData(videoDoc, updateUserRequestModel);
      }
    });
  }

  Future<void> _userUpdatedData(
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
