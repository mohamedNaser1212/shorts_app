// LoginRequestModel.dart

import '../../../../core/constants/request_data_names.dart';

class RegisterRequestModel {
  final String email;
  final String password;
  final String name;
  final String phone;

  const RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      RequestDataNames.email: email,
      RequestDataNames.password: password,
      RequestDataNames.name: name,
      RequestDataNames.phone: phone,
    };
  }
}
