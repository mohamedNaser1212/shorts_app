// user_model.dart
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 5)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String id;
  @HiveField(4)
  final String fcmToken;
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
    required this.fcmToken,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        phone = json['phone'],
        id = json['id'],
        fcmToken = json['fcmToken'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'fcmToken': fcmToken,
    };
  }
}
