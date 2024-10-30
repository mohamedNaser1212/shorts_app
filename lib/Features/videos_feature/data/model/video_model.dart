import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';
import '../../domain/video_entity/video_entity.dart';

class VideoModel extends VideoEntity {
  final String? sharedUserDescription;

  VideoModel({
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    required super.user,
    required super.description,
    this.sharedUserDescription,
    super.sharedBy,
    super.isShared = false,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json[RequestDataNames.id] ?? '',
      thumbnail: json[RequestDataNames.thumbnail] ?? '',
      videoUrl: json[RequestDataNames.videoUrl] ?? '',
      description: json[RequestDataNames.description],
      sharedUserDescription: json[RequestDataNames.sharedUserDescription],
      user: UserEntity.fromJson(json[RequestDataNames.user]),
      sharedBy: json[RequestDataNames.sharedBy] != null
          ? UserEntity.fromJson(json[RequestDataNames.sharedBy])
          : null,
      isShared: json[RequestDataNames.isShared] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.id: id,
      RequestDataNames.thumbnail: thumbnail,
      RequestDataNames.videoUrl: videoUrl,
      RequestDataNames.description: description,
      RequestDataNames.sharedUserDescription: sharedUserDescription,
      RequestDataNames.user: user.toJson(),
      if (sharedBy != null) RequestDataNames.sharedBy: sharedBy!.toJson(),
      RequestDataNames.isShared: isShared,
    };
  }
}
