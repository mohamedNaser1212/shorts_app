import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';

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

  factory FavouritesVideoModel.fromJson(Map<String, dynamic> json) {
    return FavouritesVideoModel(
      id: json[RequestDataNames.id] ?? '',
      thumbnail: json[RequestDataNames.thumbnail] ?? '',
      videoUrl: json[RequestDataNames.videoUrl] ?? '',
      description: json[RequestDataNames.description],
      user: UserModel.fromJson(json[RequestDataNames.user]),
      isFavourite: json[RequestDataNames.isFavourite] ?? false,
    );
  }
  // @override
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     RequestDataNames.thumbnail: thumbnail,
  //     'videoUrl': videoUrl,
  //     'description': description,
  //     'user': user.toJson(),
  //     'isFavourite': isFavourite,
  //   };
  // }
}
