import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';

import '../../../../Features/authentication_feature/data/user_model/user_model.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource();

  Future<UserModel> getUser(String? userId);
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  @override
  Future<UserModel> getUser(String? userId) async {
    final userDoc = await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userId)
        .get();
    print(userDoc.data());
    return UserModel.fromJson(userDoc.data()!);
  }
}
