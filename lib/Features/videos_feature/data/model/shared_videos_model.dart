import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';
import '../../domain/video_entity/video_entity.dart';
import 'package:intl/intl.dart';

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
        DateFormat('yyyy-MM-dd hh:mm a').format(shareVideoDate!);
  }

  ShareVideoModel.fromJson(Map<String, dynamic>? json) {
    videoModel = VideoModel.fromJson(json!);
    shareUserId = json['shareUserId'];
    shareUserName = json['shareUserName'];
    shareUserImage = json['shareUserImage'];
    shareVideoText = json['shareVideoText'];
    formattedShareVideoDate = json['shareDate'];
    isShared = json['isShared'];
    likes = List.from(json['likes']).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      ...videoModel!.toJson
      (),
      'videoId': videoModel!.id,
      'shareUserId': shareUserId,
      'shareUserName': shareUserName,
      'shareUserImage': shareUserImage,
      'shareVideoText': shareVideoText,
      'shareDate': formattedShareVideoDate,
      'isShared': isShared,
      'likes': likes.map((e) => e).toList(),
    };
  }
}
