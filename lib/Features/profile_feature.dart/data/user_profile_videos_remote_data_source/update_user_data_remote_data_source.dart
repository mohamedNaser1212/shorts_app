import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  }) async {
    await firestore.collection(CollectionNames.users).doc(userId).update(
      updateUserRequestModel.toMap(),
    );

    await firestore.collection(CollectionNames.users)
        .doc(userId)
        .collection(CollectionNames.videos)
        .get()
        .then((videoQuerySnapshot) {
      for (var videoDoc in videoQuerySnapshot.docs) {
        videoDoc.reference.update({
          'user.name': updateUserRequestModel.name, 
          'user.profilePic': updateUserRequestModel.imageUrl,
        });
      }
    });
    await firestore.collection(CollectionNames.videos)
        .where('user.id', isEqualTo: userId) 
        .get()
        .then((videoQuerySnapshot) {
      for (var videoDoc in videoQuerySnapshot.docs) {
        videoDoc.reference.update({
          'user.name': updateUserRequestModel.name, 
          'user.profilePic': updateUserRequestModel.imageUrl, 
        });
      }
    });

    await firestore.collection(CollectionNames.favourites)
        .where('user.id', isEqualTo: userId) 
        .get()
        .then((favoritesQuerySnapshot) {
      for (var favoriteDoc in favoritesQuerySnapshot.docs) {
        favoriteDoc.reference.update({
          'user.name': updateUserRequestModel.name, 
          'user.profilePic': updateUserRequestModel.imageUrl, 
        });
      }
    });

    DocumentSnapshot userDoc =
        await firestore.collection(CollectionNames.users).doc(userId).get();
    final userData = userDoc.data() as Map<String, dynamic>;

    return UserModel.fromJson(userData);
  }
}
