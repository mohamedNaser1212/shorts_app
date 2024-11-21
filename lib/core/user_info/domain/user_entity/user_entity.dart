import 'package:hive/hive.dart';

import '../../../utils/constants/request_data_names.dart';

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
  int followersCount;
  @HiveField(8)
  int followingCount;
  @HiveField(9)
  int likesCount;
  @HiveField(10)
  final bool isVerified;

  UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
    required this.fcmToken,
    required this.profilePic,
    required this.bio,
    this.followersCount = 0,
    this.followingCount = 0,
    this.likesCount = 0,
    this.isVerified = false,
  });
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json[RequestDataNames.name] ?? '',
      email: json[RequestDataNames.email] ?? '',
      phone: json[RequestDataNames.phone] ?? '',
      id: json[RequestDataNames.id] ?? '',
      fcmToken: json[RequestDataNames.fcmToken] ?? '',
      profilePic: json[RequestDataNames.profilePic] ?? '',
      bio: json[RequestDataNames.bio] ?? '',
      isVerified: json[RequestDataNames.isVerified] ?? false,
      followersCount: json[RequestDataNames.followersCount] ?? 0,
      followingCount: json[RequestDataNames.followingCount] ?? 0,
      likesCount: json[RequestDataNames.likesCount] ?? 0,
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
      RequestDataNames.followersCount: followersCount,
      RequestDataNames.followingCount: followingCount,
      RequestDataNames.likesCount: likesCount,
    };
  }
  // factory UserEntity.fromJson(Map<String, dynamic> json) {
  //   return UserEntity(
  //     name: json[RequestDataNames.name],
  //     email: json[RequestDataNames.email],
  //     phone: json[RequestDataNames.phone],
  //     id: json[RequestDataNames.id],
  //     fcmToken: json[RequestDataNames.fcmToken],
  //     profilePic: json[RequestDataNames.profilePic],
  //     bio: json[RequestDataNames.bio],
  //     followersCount: json[RequestDataNames.followersCount] ??
  //         0, // Set default if not present
  //     followingCount: json[RequestDataNames.followingCount] ??
  //         0, // Set default if not present
  //     likesCount:
  //         json[RequestDataNames.likesCount] ?? 0, // Set default if not present
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     RequestDataNames.name: name,
  //     RequestDataNames.email: email,
  //     RequestDataNames.phone: phone,
  //     RequestDataNames.id: id,
  //     RequestDataNames.fcmToken: fcmToken,
  //     RequestDataNames.profilePic: profilePic,
  //     RequestDataNames.bio: bio,
  //     RequestDataNames.followersCount: followersCount,
  //     RequestDataNames.followingCount: followingCount,
  //     RequestDataNames.likesCount: likesCount,
  //   };
  // }
}
