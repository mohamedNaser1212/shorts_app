import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../network/firebase_manager/collection_names.dart';

abstract class UserInfoRemoteDataSource {
  const UserInfoRemoteDataSource._();

  Future<UserModel> getUser({
    required String uId,
  });
 // Future<List<Map<String, UserModel>>> getUserVideos();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  @override
  Future<UserModel> getUser({
    required String uId,
  }) async {
    final userDoc = await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(uId)
        .get();
    return UserModel.fromJson(userDoc.data()!);
  }

  // @override
  // Future<List<Map<String, UserModel>>> getUserVideos() async {
  //   final videoDocs = await FirebaseFirestore.instance
  //       .collection(CollectionNames.users)
  //       .doc()
  //       .collection(CollectionNames.videos)
  //       .get();

  //   return videoDocs.docs
  //       .map((videoDoc) => {
  //             videoDoc.id: UserModel.fromJson(videoDoc.data()),
  //           })
  //       .toList();
  // }
}
