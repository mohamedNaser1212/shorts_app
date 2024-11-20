import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';
import 'package:shorts/core/network/firebase_manager/collection_names.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

import '../../../../../core/managers/image_picker_manager/image_picker_manager.dart';
import '../../../domain/models/update_request_model.dart';

abstract class UpdateUserDataRemoteDataSource {
  const UpdateUserDataRemoteDataSource._();

  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
    required File imageFile,
  });
}

class UpdateUserDataSourceImpl implements UpdateUserDataRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseHelper firebaseHelper;

  UpdateUserDataSourceImpl({required this.firebaseHelper});

  @override
  Future<UserModel> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
    required File imageFile,
  }) async {
    // if (currentUser != null) {
    //   if (updateUserRequestModel.email != currentUser.email) {
    //     await _updateUserEmailInAuth(
    //       currentUser: currentUser,
    //       newEmail: updateUserRequestModel.email,
    //     );
    //   }
    // }

    String? uploadedImageUrl;
    uploadedImageUrl = await uploadImage(
      imageUrl: updateUserRequestModel.imageUrl,
      imageFile: imageFile,
    );
  
    // Prepare data for Firestore update
    Map<String, dynamic> updatedData = {
      'name': updateUserRequestModel.name,
      'phone': updateUserRequestModel.phone,
      'bio': updateUserRequestModel.bio,
      'profilePic': uploadedImageUrl ?? updateUserRequestModel.imageUrl,
    };

    // Update user data in Firestore
    await firestore
        .collection(CollectionNames.users)
        .doc(userId)
        .update(updatedData);

    DocumentSnapshot userDoc =
        await firestore.collection(CollectionNames.users).doc(userId).get();
    final userData = userDoc.data() as Map<String, dynamic>;

    return UserModel.fromJson(userData);
  }

  Future<String?> uploadImage({
    required String imageUrl,
    required File imageFile,
  }) async {
    // Assume ImagePickerHelper.uploadImage is the method you're using to upload
    try {
      final uploadedImageUrl = await ImagePickerHelper.uploadImage(
        imageFile,
        'profile_images/${imageUrl.split('/').last}', // Use a path for the uploaded image
      );
      return uploadedImageUrl;
    } catch (e) {
      print('Image upload failed: $e');
      return null;
    }
  }
}
