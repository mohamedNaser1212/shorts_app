import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import 'package:shorts/core/update_user_data/update_user_data.dart';

import '../../../domain/models/update_request_model.dart';

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
  final FirebaseHelper firebaseHelper;

  UpdateUserDataSourceImpl({required this.firebaseHelper});

  @override
  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  }) async {
    // if (currentUser != null) {
    //   if (updateUserRequestModel.email != currentUser.email) {
    //     await _updateUserEmailInAuth(
    //       currentUser: currentUser,
    //       newEmail: updateUserRequestModel.email,
    //     );
    //   }
    // }

    await UpdateUserData.updateUserData(
      updateUserRequestModel: updateUserRequestModel,
      userId: userId,
      firebaseHelper: firebaseHelper,
      firestore: firestore,
      auth: auth,
    );

    DocumentSnapshot userDoc =
        await firestore.collection(CollectionNames.users).doc(userId).get();
    final userData = userDoc.data() as Map<String, dynamic>;

    return UserModel.fromJson(userData);
  }
}
