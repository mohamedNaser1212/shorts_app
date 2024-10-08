// LoginRequestModel.dart

import '../../../../core/utils/constants/request_data_names.dart';

class RegisterRequestModel {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String profilePic;
  final String bio;


  const RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.profilePic,
   required  this.bio ,
  });

  Map<String, dynamic> toMap() {
    return {
      RequestDataNames.email: email,
      RequestDataNames.password: password,
      RequestDataNames.name: name,
      RequestDataNames.phone: phone,
      RequestDataNames.profilePic: profilePic,
      RequestDataNames.bio: bio,
    };
  }
}
