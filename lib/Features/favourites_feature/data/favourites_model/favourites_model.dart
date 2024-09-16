import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';

import '../../../authentication_feature/data/user_model/user_model.dart';

class FavouritesVideoModel extends FavouritesEntity {
  FavouritesVideoModel({
    required super.id,
    required super.thumbnail,
    required super.videoUrl,
    super.description,
    required super.user,
    super.isFavourite = false,
  });

  // Convert JSON to instance
  factory FavouritesVideoModel.fromJson(Map<String, dynamic> json) {
    return FavouritesVideoModel(
      id: json['id'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'],
      user: UserModel.fromJson(json['user']),
      isFavourite: json['isFavourite'] ?? false,
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
      'isFavourite': isFavourite,
    };
  }
}
