import 'package:dartz/dartz.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';

import '../../../../core/managers/error_manager/failure.dart';

class GetFavouritesCountUseCase {
  final FavouritesRepo favouritesRepo;

  GetFavouritesCountUseCase({required this.favouritesRepo});

  Future<Either<Failure, num>> getFavouritesCount({
    required String videoId,
  }) async {
    return await favouritesRepo.getFavouritesCount(videoId: videoId);
  }
}
