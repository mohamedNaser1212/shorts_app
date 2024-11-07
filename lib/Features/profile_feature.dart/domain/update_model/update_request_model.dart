import 'package:shorts/core/utils/constants/request_data_names.dart';

class UpdateUserRequestModel {
  final String name;
  final String phone;
  final String imageUrl;
  final String bio;

  UpdateUserRequestModel({
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      RequestDataNames.name: name,
      RequestDataNames.phone: phone,
      RequestDataNames.profilePic: imageUrl,
      RequestDataNames.bio: bio,
    };
  }
}
