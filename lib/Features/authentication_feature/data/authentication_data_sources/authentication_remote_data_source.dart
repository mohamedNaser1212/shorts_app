import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
    //String? fcmToken = await FirebaseMessaging.instance.getToken();

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(uId)
        .get();

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    // UserModel user = UserModel(
    //   name: userData['name'],
    //   email: userData['email'] ?? email,
    //   phone: userData['phone'],
    //   id: userData['id'],
    //   fcmToken: userData['fcmToken'],
    // );

    return UserModel.fromJson(userData);
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

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    UserModel user = UserModel(
      name: name,
      email: email,
      phone: phone,
      id: uId ?? '',
      fcmToken: fcmToken ?? '',
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
}
