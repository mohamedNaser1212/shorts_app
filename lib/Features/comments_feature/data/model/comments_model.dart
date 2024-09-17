import '../../../authentication_feature/data/user_model/user_model.dart';
import '../../domain/comments_entity/comments_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.content,
    required super.user,
    required super.timestamp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      user: UserModel.fromJson(json['user']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'user': user.toJson(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
