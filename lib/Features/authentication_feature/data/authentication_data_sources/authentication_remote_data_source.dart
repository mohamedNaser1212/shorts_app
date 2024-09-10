import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/consts.dart';
import '../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../core/network/firebase_manager/firebase_helper.dart';
import '../user_model/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  AuthenticationDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    uId = userCredential.user!.uid;

    UserModel user = UserModel(
      name: '',
      email: email,
      phone: '',
      id: uId ?? '',
    );
    return user;
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    uId = userCredential.user!.uid;

    UserModel user = UserModel(
      name: name,
      email: email,
      phone: phone,
      id: uId ?? '',
    );

    createUserData(user: user);

    return user;
  }

  void createUserData({required UserModel user}) {
    FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(user.id)
        .set(user.toJson());
  }

  // Method to upload video data into the user's collection
  Future<void> uploadVideo(
      {required String videoUrl, required String title}) async {
    final videoData = {
      'videoUrl': videoUrl,
      'title': title,
      'uploadDate': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(uId)
        .collection('videos')
        .add(videoData);
  }
}
