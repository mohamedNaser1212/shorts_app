import 'package:shorts/core/utils/constants/request_data_names.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
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
      id: json[RequestDataNames.id] ?? '',
      content: json[RequestDataNames.content] ?? '',
      user: UserEntity.fromJson(json[RequestDataNames.user]),
      timestamp: DateTime.parse(json[RequestDataNames.timestamp] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.id: id,
      RequestDataNames.content: content,
      RequestDataNames.user: user.toJson(),
      RequestDataNames.timestamp: timestamp.toIso8601String(),
    };
  }
}
