import 'package:hive/hive.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

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
  final UserEntity user;


  VideoEntity({
    required this.id,
    required this.thumbnail,
    required this.videoUrl,
    this.description,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'description': description,
      'user': user.toJson(),
    };
  }

  factory VideoEntity.fromJson(Map<String, dynamic> json) {
    return VideoEntity(
      id: json['id'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'],
      user: UserEntity.fromJson(json['user']),
   
    );
  }
}
