import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../authentication_feature/data/user_model/user_model.dart';

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
    required String videoId,
    required UserEntity user,
    required UserModel userModel,
  }) async {
    return await favouritesRepo.toggleFavouriteVideo(
      videoId: videoId,
      user: user,
      userModel: userModel,
    );
  }
}
