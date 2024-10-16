import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shorts/core/clear_token/clear_token.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';
import 'package:shorts/firebase_helper.dart';
import '../user_model/login_request_model.dart';
import '../user_model/register_request_model.dart';
import '../user_model/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource._();

  Future<UserModel> login({
    required LoginRequestModel requestModel,
  });

  Future<UserModel> register({
    required RegisterRequestModel requestModel,
  });

  Future<void> signOut();
}

class AuthenticationDataSourceImpl implements AuthenticationRemoteDataSource {
  bool fcmTokenAssigned = false;

  final FirebaseHelperManager firebaseHelper;

  AuthenticationDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<UserModel> login({
    required LoginRequestModel requestModel,
  }) async {
    UserCredential userCredential =
        await _signInWithEmailAndPassword(requestModel);
    DocumentSnapshot<Object?> userDoc =
        await _accessUsersCollection(userCredential);
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    if (userData[RequestDataNames.fcmToken] == null ||
        userData[RequestDataNames.fcmToken].isEmpty) {
      String? newFcmToken = await FirebaseMessaging.instance.getToken();

      await FirebaseFirestore.instance
          .collection(CollectionNames.users)
          .doc(userCredential.user!.uid)
          .update({
        RequestDataNames.fcmToken: newFcmToken ?? '',
      });

      userData[RequestDataNames.fcmToken] = newFcmToken;
      await ClearToken.clearToken(
        userId: userCredential.user!.uid,
        fcmToken: newFcmToken!,
        firebaseHelper: firebaseHelper,
      );
    }

    fcmTokenAssigned = true;
    return UserModel.fromJson(userData);
  }

  Future<DocumentSnapshot<Object?>> _accessUsersCollection(
      UserCredential userCredential) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(userCredential.user!.uid)
        .get();
    return userDoc;
  }

  Future<UserCredential> _signInWithEmailAndPassword(
    LoginRequestModel requestModel,
  ) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: requestModel.email,
      password: requestModel.password,
    );
    return userCredential;
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

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    Map<String, dynamic> userMap = requestModel.toMap();
    userMap[RequestDataNames.id] = userCredential.user!.uid;
    userMap[RequestDataNames.fcmToken] = fcmToken ?? '';

    UserModel user = UserModel.fromJson(userMap);
    await createUserData(user: user);

    DocumentSnapshot<Object?> userDoc =
        await _accessUsersCollection(userCredential);
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    return UserModel.fromJson(userData);
  }

  Future<void> createUserData({required UserEntity user}) async {
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(user.id)
        .set(user.toJson());
  }

  @override
  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (fcmTokenAssigned) {

        await firebaseHelper.updateDocument(
          collectionPath: CollectionNames.users,
          docId: user.uid,
          data: {RequestDataNames.fcmToken: ''},
        );
        
        // await FirebaseFirestore.instance
        //     .collection(CollectionNames.users)
        //     .doc(user.uid)
        //     .update({RequestDataNames.fcmToken: ''});

        await ClearToken.clearToken(
          userId: user.uid,
          fcmToken: '',
          firebaseHelper: firebaseHelper,
        );
      }
      await FirebaseAuth.instance.signOut();
      fcmTokenAssigned = false;
    }
  }
}
