import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

class ToggleFavouritesUseCase {
  final FavouritesRepo favouritesRepo;

  ToggleFavouritesUseCase({required this.favouritesRepo});


 Future toggleFavouriteVideo({
    required  VideoEntity videoEntity,
    required UserEntity userModel,
  }) async {
    return await favouritesRepo.toggleFavouriteVideo(
      videoEntity: videoEntity,
      userModel: userModel,
    );
  }

}
