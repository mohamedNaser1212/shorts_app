import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';

import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../constants/consts.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource();

  Future<UserModel> getUser();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  @override
  Future<UserModel> getUser() async {
    final userDoc = await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(uId)
        .get();
    print(userDoc.data());
    return UserModel.fromJson(userDoc.data()!);
  }
}
