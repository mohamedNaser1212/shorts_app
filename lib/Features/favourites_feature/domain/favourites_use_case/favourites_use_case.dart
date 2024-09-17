import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

class FavouritesUseCase {
  final FavouritesRepo favouritesRepo;

  FavouritesUseCase({required this.favouritesRepo});

  Future getFavouriteVideos() async {
    return await favouritesRepo.getFavouriteVideos();
  }

  Future toggleFavouriteVideo({
    required String videoId,
    required UserEntity user,
  }) async {
    return await favouritesRepo.toggleFavouriteVideo(
      videoId: videoId,
      user: user,
    );
  }
}
