import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../comments_feature/data/model/comments_model.dart';
import '../../domain/video_entity/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    required super.user,
    required super.comments,
    super.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'],
      user: UserEntity.fromJson(json['user']),
      comments: (json['comments'] as List)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'description': description,
      'user': user.toJson(),
      'comments': comments.map((e) => e.toJson()).toList(),
    };
  }
}
