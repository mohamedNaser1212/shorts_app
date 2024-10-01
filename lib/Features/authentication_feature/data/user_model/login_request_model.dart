import '../../../../core/utils/constants/request_data_names.dart';

class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      RequestDataNames.email: email,
      RequestDataNames.password: password,
    };
  }
}
