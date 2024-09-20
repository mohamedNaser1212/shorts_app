import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';

class FavouritesUseCase {
  final FavouritesRepo favouritesRepo;

  FavouritesUseCase({required this.favouritesRepo});

  Future getFavouriteVideos({
    required UserEntity user,
  }) async {
    return await favouritesRepo.getFavouriteVideos(
      user: user,
    );
  }

  Future toggleFavouriteVideo({
    required VideoEntity videoEntity,
    required UserEntity userModel,
  }) async {
    return await favouritesRepo.toggleFavouriteVideo(
      videoEntity: videoEntity,
      userModel: userModel,
    );
  }
}
