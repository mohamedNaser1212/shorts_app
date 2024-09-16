import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';

class FavouritesUseCase {
  final FavouritesRepo favouritesRepo;

  FavouritesUseCase({required this.favouritesRepo});

  Future getFavouriteVideos() async {
    return await favouritesRepo.getFavouriteVideos();
  }

  Future toggleFavouriteVideo({
    required String videoId,
  }) async {
    return await favouritesRepo.toggleFavouriteVideo(
      videoId: videoId,
    );
  }
}
