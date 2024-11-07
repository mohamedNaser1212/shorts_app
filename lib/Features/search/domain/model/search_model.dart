import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

class SearchModel {
  final String id;
  final String thumbnail;
  final String videoUrl;
  final String description;
  final UserEntity user;

  SearchModel({
    required this.id,
    required this.thumbnail,
    required this.videoUrl,
    required this.description,
    required this.user,
  });

  // Factory constructor to create a SearchModel from a Firestore document
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'] ?? '',
      user: UserEntity.fromJson(json['user']),
    );
  }
}
