import 'package:hive/hive.dart';

import '../../../comments_feature/domain/comments_entity/comments_entity.dart';

part 'video_entity.g.dart';

@HiveType(typeId: 0)
class VideoEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String thumbnail;
  @HiveField(2)
  final String videoUrl;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final dynamic user;
  @HiveField(5)
  final List<CommentEntity> comments;

  VideoEntity({
    required this.id,
    required this.thumbnail,
    required this.videoUrl,
    this.description,
    required this.user,
    required this.comments,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'thumbnail': thumbnail,
  //     'videoUrl': videoUrl,
  //     'description': description,
  //     'user': user.toJson(),
  //     'comments': comments.map((e) => e.toJson()).toList(),
  //   };
  // }

  // factory VideoEntity.fromJson(Map<String, dynamic> json) {
  //   return VideoEntity(
  //     id: json['id'] ?? '',
  //     thumbnail: json['thumbnail'] ?? '',
  //     videoUrl: json['videoUrl'] ?? '',
  //     description: json['description'],
  //     user: UserModel.fromJson(json['user']),
  //     comments: (json['comments'] as List)
  //         .map((e) => CommentEntity.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //   );
  // }
}
