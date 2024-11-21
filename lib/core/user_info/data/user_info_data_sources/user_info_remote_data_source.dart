import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

import '../../../network/firebase_manager/collection_names.dart';
import '../../domain/user_entity/user_entity.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource._();

  Future<UserEntity> getUser({
    required String uId,
  });
  Future<UserEntity> getUserById({
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
  Future<UserEntity> getUser({
    required String uId,
  }) async {
    final userData = await firebaseHelper.getDocument(
      collectionPath: CollectionNames.users,
      docId: uId,
    );

    return UserEntity.fromJson(userData ?? {});
  }

  @override
  Future<UserEntity> getUserById({required String uId}) async {
    final userData = await firebaseHelper.getDocument(
      collectionPath: CollectionNames.users,
      docId: uId,
    );

    return UserEntity.fromJson(userData ?? {});
  }
}
