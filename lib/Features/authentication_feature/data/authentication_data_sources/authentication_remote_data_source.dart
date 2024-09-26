import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/constants/consts.dart';
import '../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../core/network/firebase_manager/firebase_helper.dart';
import '../user_model/login_request_model.dart';
import '../user_model/register_request_model.dart';
import '../user_model/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();
  Future<UserModel> login({
    required LoginRequestModel requestModel,
  });
  Future<UserModel> register({
    required RegisterRequestModel requestModel,
  });
}

class AuthenticationDataSourceImpl implements AuthenticationRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  AuthenticationDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<UserModel> login({
    required LoginRequestModel requestModel,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: requestModel.email,
      password: requestModel.password,
    );
    uId = userCredential.user!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(uId)
        .get();

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    return UserModel.fromJson(userData);
  }

  @override
  Future<UserModel> register({
    required RegisterRequestModel requestModel,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: requestModel.email,
      password: requestModel.password,
    );
    uId = userCredential.user!.uid;

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    UserModel user = UserModel(
      name: requestModel.name,
      email: requestModel.email,
      phone: requestModel.phone,
      id: uId ?? '',
      fcmToken: fcmToken ?? '',
    );

    await createUserData(user: user);

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(uId)
        .get();

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    return UserModel.fromJson(userData);
  }

  Future<void> createUserData({required UserModel user}) async {
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(user.id)
        .set(user.toJson());
  }
}
