import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';
import '../../domain/video_entity/video_entity.dart';

class VideoModel extends VideoEntity {
  final UserEntity? sharedBy; // Optional field for the user who shared

  VideoModel({
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    required super.user,
    required super.description,
    this.sharedBy,
  });

  VideoModel copyWith({
    String? id,
    String? thumbnail,
    String? videoUrl,
    UserEntity? user,
    UserEntity? sharedBy, // Optional shared user
    String? description,
  }) {
    return VideoModel(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      videoUrl: videoUrl ?? this.videoUrl,
      user: user ?? this.user,
      sharedBy: sharedBy ?? this.sharedBy,
      description: description ?? this.description,
    );
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json[RequestDataNames.id] ?? '',
      thumbnail: json[RequestDataNames.thumbnail] ?? '',
      videoUrl: json[RequestDataNames.videoUrl] ?? '',
      description: json[RequestDataNames.description],
      user: UserEntity.fromJson(json[RequestDataNames.user]),
      sharedBy: json[RequestDataNames.sharedBy] != null
          ? UserEntity.fromJson(json[RequestDataNames.sharedBy])
          : null, // Shared user if available
    );
  }

  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.id: id,
      RequestDataNames.thumbnail: thumbnail,
      RequestDataNames.videoUrl: videoUrl,
      RequestDataNames.description: description,
      RequestDataNames.user: user.toJson(),
      if (sharedBy != null)
        RequestDataNames.sharedBy: sharedBy!.toJson(), // Shared user if exists
    };
  }
}
