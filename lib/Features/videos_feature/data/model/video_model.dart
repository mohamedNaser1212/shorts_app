import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';

import '../../domain/video_entity/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    required super.user,
    super.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json[RequestDataNames.id] ?? '',
      thumbnail: json[RequestDataNames.thumbnail] ?? '',
      videoUrl: json[RequestDataNames.videoUrl] ?? '',
      description: json[RequestDataNames.description],
      user: UserEntity.fromJson(json[RequestDataNames.user]),
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.id: id,
      RequestDataNames.thumbnail: thumbnail,
      RequestDataNames.videoUrl: videoUrl,
      RequestDataNames.description: description,
      RequestDataNames.user: user.toJson(),
    };
  }
}
