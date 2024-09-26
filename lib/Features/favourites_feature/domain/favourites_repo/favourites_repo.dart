import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../favourite_entitiy.dart';

abstract class FavouritesRepo {
  Future<Either<Failure, List<FavouritesEntity>>> getFavouriteVideos({
    required UserEntity user,
  });
  Future<Either<Failure, bool>> toggleFavouriteVideo({
    required FavouritesEntity videoEntity,
    required UserEntity userModel,
  });
}
