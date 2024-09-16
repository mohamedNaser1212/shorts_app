import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../favourite_entitiy.dart';

abstract class FavouritesRepo {
  Future<Either<Failure, List<FavouritesEntity>>> getFavouriteVideos();
  Future<Either<Failure, bool>> toggleFavouriteVideo({
    required String videoId,
  });
}
