import 'package:hive/hive.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../authentication_feature/data/user_model/user_model.dart';

part 'comments_entity.g.dart';

@HiveType(typeId: 4)
class CommentEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final UserEntity user;
  @HiveField(3)
  final DateTime timestamp;

  const CommentEntity({
    required this.id,
    required this.content,
    required this.user,
    required this.timestamp,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      user: UserModel.fromJson(json['user']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'user': user.toJson(),
    };
  }
}
