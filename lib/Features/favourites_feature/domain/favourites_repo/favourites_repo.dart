import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../authentication_feature/data/user_model/user_model.dart';
import '../favourite_entitiy.dart';

abstract class FavouritesRepo {
  Future<Either<Failure, List<FavouritesEntity>>> getFavouriteVideos({
    required UserEntity user,
  });
  Future<Either<Failure, bool>> toggleFavouriteVideo({
    required String videoId,
    required UserEntity user,
    required UserModel userModel,
  });
}
