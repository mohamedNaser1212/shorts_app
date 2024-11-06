import 'package:hive/hive.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';

// import '../../../utils/constants/consts.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 5)
class UserEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  String? id;
  @HiveField(4)
  final String fcmToken;
  @HiveField(5)
  final String profilePic;
  @HiveField(6)
  final String bio;
  @HiveField(7)
  bool isVerified = false;

  UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
    required this.fcmToken,
    required this.profilePic,
    required this.bio,
    required this.isVerified,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json[RequestDataNames.name],
      email: json[RequestDataNames.email],
      phone: json[RequestDataNames.phone],
      id: json[RequestDataNames.id],
      fcmToken: json[RequestDataNames.fcmToken],
      profilePic: json[RequestDataNames.profilePic],
      bio: json[RequestDataNames.bio],
      isVerified: json[RequestDataNames.isVerified] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.name: name,
      RequestDataNames.email: email,
      RequestDataNames.phone: phone,
      RequestDataNames.id: id,
      RequestDataNames.fcmToken: fcmToken,
      RequestDataNames.profilePic: profilePic,
      RequestDataNames.bio: bio,
      RequestDataNames.isVerified: isVerified,
    };
  }
}
