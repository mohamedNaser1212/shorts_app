import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';
import 'package:shorts/Features/profile_feature.dart/domain/update_model/update_request_model.dart';

abstract class UpdateUserDataRemoteDataSource {
  const UpdateUserDataRemoteDataSource._();

  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  });
  // Future<bool> signOut();
}

class UpdateUserDataSourceImpl implements UpdateUserDataRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .update(updateUserRequestModel.toMap());

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(userId).get();
    final userData = userDoc.data() as Map<String, dynamic>;

    return UserModel.fromJson(userData);
  }

  // @override
  // Future<bool> signOut() async {
  //   await firebaseAuth.signOut();
  //   return true;
  // }
}
