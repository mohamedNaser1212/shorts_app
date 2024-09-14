import '../../../authentication_feature/data/user_model/user_model.dart';
import '../../domain/video_entity/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel({
    required super.user, // UserModel
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    super.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'],
      user: UserModel.fromJson(json['user']),
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
    };
  }
}
