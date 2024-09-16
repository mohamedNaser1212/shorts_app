// import '../../../authentication_feature/data/user_model/user_model.dart';
// import '../../../videos_feature/domain/video_entity/video_entity.dart';
//
// class FavouritesVideoModel extends VideoEntity {
//    FavouritesVideoModel({
//     required super.user,
//     required super.id,
//     required super.thumbnail,
//     required super.videoUrl,
//     super.description,
//   });
//
//   factory FavouritesVideoModel.fromJson(Map<String, dynamic> json) {
//     return FavouritesVideoModel(
//       id: json['id'] ?? '',
//       thumbnail: json['thumbnail'] ?? '',
//       videoUrl: json['videoUrl'] ?? '',
//       description: json['description'],
//       user: UserModel.fromJson(json['user']),
//     );
//   }
//
//   // Convert instance to JSON for Firestore
//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'thumbnail': thumbnail,
//       'videoUrl': videoUrl,
//       'description': description,
//       'user': user.toJson(),
//     };
//   }
// }
