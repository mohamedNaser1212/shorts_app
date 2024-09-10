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

  void createUserData({
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
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      uId = value.user!.uid;

      createUserData(
          email: email, password: password, name: name, phone: phone);
    });

    return UserModel(
      name: name,
      email: email,
      phone: phone,
      id: uId ?? '',
    );
  }

  @override
  void createUserData(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    UserModel user = UserModel(
      name: name,
      email: email,
      phone: phone,
      id: uId ?? '',
    );

    FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(uId)
        .set(user.toJson());
  }
}
