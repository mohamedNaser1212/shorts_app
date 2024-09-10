import 'package:hive/hive.dart';

import '../../../constants/consts.dart';

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
  String id = uId ?? '';

  UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
  });
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'id': id,
    };
  }
}
