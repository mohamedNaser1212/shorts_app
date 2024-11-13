import 'package:hive/hive.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

part 'comments_entity.g.dart';

@HiveType(typeId: 4)
class CommentEntity {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final UserEntity user;

  @HiveField(3)
  final DateTime timestamp;

  CommentEntity({
    this.id = '',
    required this.content,
    required this.user,
    required this.timestamp,
  });
}
