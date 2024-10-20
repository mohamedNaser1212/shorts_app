import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';

class GetFavouritesUseCase {
  final FavouritesRepo favouritesRepo;

  GetFavouritesUseCase({required this.favouritesRepo});

  Future getFavouriteVideos({
    required UserEntity user,
  }) async {
    return await favouritesRepo.getFavouriteVideos(
      user: user,
    );
  }
}
