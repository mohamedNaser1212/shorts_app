import 'package:hive/hive.dart';

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
  final String id;

  const UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
  });
}
