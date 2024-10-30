import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:intl/intl.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';

class ShareVideoModel {
  VideoModel? videoModel;
  String? videoId;
  String? shareUserId;
  String? shareUserName;
  String? shareUserImage;
  String? shareVideoText;
  DateTime? shareVideoDate;
  String? formattedShareVideoDate;
  bool isShared = true;
  List<String> likes = [];

  ShareVideoModel({
    this.videoId,
    required this.videoModel,
    required this.shareUserId,
    required this.shareUserName,
    required this.shareUserImage,
    required this.shareVideoText,
    this.likes = const [],
  }) {
    shareVideoDate = DateTime.now();
    formattedShareVideoDate =
        DateFormat('MMMM dd, yyyy').format(shareVideoDate!);
  }

  ShareVideoModel.fromJson(Map<String, dynamic>? json) {
    videoModel = VideoModel.fromJson(json!);
    shareUserId = json['shareUser Id'];
    shareUserName = json['shareUser Name'];
    shareUserImage = json['shareUser Image'];
    shareVideoText = json['shareVideoText'];
    shareVideoDate = json[RequestDataNames.timeStamp] != null
        ? DateTime.parse(json[RequestDataNames.timeStamp])
        : null; // Parse timestamp
    formattedShareVideoDate = shareVideoDate != null
        ? DateFormat('MMMM dd, yyyy').format(shareVideoDate!)
        : null; // Format timestamp for display
    formattedShareVideoDate = shareVideoDate != null
        ? DateFormat('yyyy-MM-dd hh:mm a').format(shareVideoDate!)
        : null; // Format timestamp for display
    isShared = json['isShared'] ?? false;
    likes = List.from(json['likes']).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      ...videoModel!.toJson(),
      'videoId': videoModel!.id,
      'shareUserId': shareUserId,
      'shareUserName': shareUserName,
      'shareUserImage': shareUserImage,
      'shareVideoText': shareVideoText,
      RequestDataNames.timeStamp: shareVideoDate != null
          ? shareVideoDate!.toIso8601String()
          : null, // Store DateTime as ISO 8601 string
      'isShared': isShared,
      'likes': likes,
    };
  }
}
