import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shorts/core/clear_token/clear_token.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';

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
    required File imageFile,
  });
  Future<void> verifyUser(String userId);

  Future<bool> signOut();

  Future<UserModel> signInWithGoogle();
}

class AuthenticationDataSourceImpl implements AuthenticationRemoteDataSource {
  bool fcmTokenAssigned = false;

  final FirebaseHelper firebaseHelper;

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

    bool isVerified = userCredential.user!.emailVerified;
    if (userData[RequestDataNames.isVerified] != isVerified) {
      await FirebaseFirestore.instance
          .collection(CollectionNames.users)
          .doc(userCredential.user!.uid)
          .update({RequestDataNames.isVerified: isVerified});
      userData[RequestDataNames.isVerified] = isVerified;
    }

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
    required File imageFile,
  }) async {
    String imageUrl = await _uploadProfileImage(imageFile);

    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: requestModel.email,
      password: requestModel.password,
    );

    await userCredential.user!.sendEmailVerification();

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    Map<String, dynamic> userMap = requestModel.toMap();
    userMap[RequestDataNames.id] = userCredential.user!.uid;
    userMap[RequestDataNames.fcmToken] = fcmToken ?? '';
    userMap[RequestDataNames.isVerified] = false;
    userMap[RequestDataNames.profilePic] = imageUrl;

    UserModel user = UserModel.fromJson(userMap);
    await createUserData(user: user);

    DocumentSnapshot<Object?> userDoc =
        await _accessUsersCollection(userCredential);
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    return UserModel.fromJson(userData);
  }

  Future<void> createUserData({required UserModel user}) async {
    await FirebaseFirestore.instance
        .collection(CollectionNames.users)
        .doc(user.id)
        .set(user.toJson());
  }

  Future<String> _uploadProfileImage(File imageFile) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child("profile_images/${DateTime.now().millisecondsSinceEpoch}");

      // Upload the file
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Get the image URL
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      // Handle errors
      throw Exception("Image upload failed: $e");
    }
  }

  @override
  Future<bool> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    final googleSignIn = GoogleSignIn();

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

        if (user.providerData
            .any((provider) => provider.providerId == 'google.com')) {
          await googleSignIn.signOut();
          googleSignIn.disconnect();
        }
        await ClearToken.clearToken(
          userId: user.uid,
          fcmToken: '',
          firebaseHelper: firebaseHelper,
        );
      }
      await FirebaseAuth.instance.signOut();
      fcmTokenAssigned = false;
    }
    return true;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) throw Exception("Google Sign-In aborted");

    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final firebaseUser = userCredential.user;
    final userId = firebaseUser!.uid;

    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final bool isVerified = firebaseUser.emailVerified;

    final userModel = UserModel(
      id: userId,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      phone: firebaseUser.phoneNumber ?? '',
      profilePic: firebaseUser.photoURL ?? '',
      fcmToken: await FirebaseMessaging.instance.getToken() ?? '',
      bio: '',
      isVerified: isVerified,
    );

    if (!userDoc.exists) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(userModel.toJson());
    }

    return userModel;
  }

  @override
  Future<void> verifyUser(String userId) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Refresh the user to get the latest verification status
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        // Update Firestore if email is verified
        await FirebaseFirestore.instance
            .collection(CollectionNames.users)
            .doc(userId)
            .update({RequestDataNames.isVerified: true});
      }
    }
  }
}
