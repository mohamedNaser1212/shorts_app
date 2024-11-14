import 'package:intl/intl.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';

import '../../../authentication_feature/data/user_model/user_model.dart';
import '../../domain/video_entity/video_entity.dart';

class VideoModel extends VideoEntity {
  DateTime? timeStampDateTime;

  VideoModel({
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    required super.user,
    required super.description,
    super.timeStamp,
  }) {
    if (timeStamp != null) {
      timeStampDateTime = timeStamp;
    }
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json[RequestDataNames.id] ?? '',
      thumbnail: json[RequestDataNames.thumbnail] ?? '',
      videoUrl: json[RequestDataNames.videoUrl] ?? '',
      description: json[RequestDataNames.description],
      user: UserModel.fromJson(json[RequestDataNames.user]),
      timeStamp: json[RequestDataNames.timeStamp] != null
          ? DateTime.parse(json[RequestDataNames.timeStamp])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      RequestDataNames.id: id,
      RequestDataNames.thumbnail: thumbnail,
      RequestDataNames.videoUrl: videoUrl,
      RequestDataNames.description: description,
      RequestDataNames.user: user.toJson(),
      if (timeStampDateTime != null)
        RequestDataNames.timeStamp: timeStampDateTime!.toIso8601String(),
    };
  }

  String formattedTimeStamp() {
    if (timeStampDateTime != null) {
      return DateFormat('MMMM dd, yyyy').format(timeStampDateTime!);
    }
    return '';
  }
}
