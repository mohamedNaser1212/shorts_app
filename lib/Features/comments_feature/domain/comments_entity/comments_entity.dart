import 'package:hive/hive.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';

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

  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.id: id,
      RequestDataNames.content: content,
      RequestDataNames.user: user.toJson(),
      RequestDataNames.timestamp: timestamp.toIso8601String(),
    };
  }
}
