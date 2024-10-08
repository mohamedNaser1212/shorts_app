import 'package:shorts/core/utils/constants/request_data_names.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.id,
    required super.fcmToken,
    required super.profilePic,
    required super.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[RequestDataNames.name],
      email: json[RequestDataNames.email],
      phone: json[RequestDataNames.phone],
      id: json[RequestDataNames.id],
      fcmToken: json[RequestDataNames.fcmToken],
      profilePic: json[RequestDataNames.profilePic],
      bio: json[RequestDataNames.bio],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.name: name,
      RequestDataNames.email: email,
      RequestDataNames.phone: phone,
      RequestDataNames.id: id,
      RequestDataNames.fcmToken: fcmToken,
      RequestDataNames.profilePic: profilePic,
      RequestDataNames.bio: bio,
    };
  }
}
