import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../../videos_feature/data/model/video_model.dart';

abstract class FavouritesRepo {
  Future<Either<Failure, List<VideoModel>>> getFavouriteVideos();
  Future<Either<Failure, bool>> toggleFavouriteVideo({
    required String videoId,
  });
}
