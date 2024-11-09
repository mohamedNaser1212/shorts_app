import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../network/firebase_manager/collection_names.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource._();

  Future<UserModel> getUser({
    required String uId,
  });
  Future<UserModel> getUserById({
    required String uId,
  });
  // Future<List<Map<String, UserModel>>> getUserVideos();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  const UserInfoRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<UserModel> getUser({
    required String uId,
  }) async {
    final userData = await firebaseHelper.getDocument(
      collectionPath: CollectionNames.users,
      docId: uId,
    );

    return UserModel.fromJson(userData ?? {});
  }

  @override
  Future<UserModel> getUserById({required String uId}) async {
    final userData = await firebaseHelper.getDocument(
      collectionPath: CollectionNames.users,
      docId: uId,
    );

    return UserModel.fromJson(userData ?? {});
  }
}
