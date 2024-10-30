import 'package:intl/intl.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';
import '../../domain/video_entity/video_entity.dart';



class VideoModel extends VideoEntity {
  final String? sharedUserDescription;
  DateTime? timeStampDateTime; // Add DateTime property

  VideoModel({
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    required super.user,
    required super.description,
    this.sharedUserDescription,
    super.sharedBy,
    super.isShared = false,
    super.timeStamp,
  }) {
    // Initialize DateTime from the timestamp if available
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
      sharedUserDescription: json[RequestDataNames.sharedUserDescription],
      user: UserEntity.fromJson(json[RequestDataNames.user]),
      sharedBy: json[RequestDataNames.sharedBy] != null
          ? UserEntity.fromJson(json[RequestDataNames.sharedBy])
          : null,
      isShared: json[RequestDataNames.isShared] ?? false,
      timeStamp: json[RequestDataNames.timeStamp] != null
          ? DateTime.parse(json[RequestDataNames.timeStamp])
          : null, // Parse timestamp
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
      if (timeStampDateTime != null) 
        RequestDataNames.timeStamp: timeStampDateTime!.toIso8601String(), // Store DateTime as ISO 8601 string
    };
  }

  String formattedTimeStamp() {
    if (timeStampDateTime != null) {
      return DateFormat('MMMM dd, yyyy').format(timeStampDateTime!);
    }
    return ''; // Return empty string if timeStamp is null
  }
}