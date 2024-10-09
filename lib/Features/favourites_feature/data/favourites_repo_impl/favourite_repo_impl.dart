import 'package:dartz/dartz.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_data_source/favourites_local_data_source.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_data_source/favourites_remote_data_source.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';

class FavouritesRepoImpl implements FavouritesRepo {
  final FavouritesRemoteDataSource remoteDataSource;
  final RepoManager repoManager;
  final FavouritesLocalDataSource favouritesLocalDataSource;

  FavouritesRepoImpl({
    required this.remoteDataSource,
    required this.repoManager,
    required this.favouritesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavouriteVideos({
    required UserEntity user,
  }) async {
    return repoManager.call(
      action: () async {
        final cachedFavourites =
            await favouritesLocalDataSource.getFavouriteVideos();
        if (cachedFavourites.isNotEmpty) {
          return cachedFavourites;
        } else {
          final favourites = await remoteDataSource.getFavouriteVideos(
            user: user,
          );

          await favouritesLocalDataSource.saveFavouriteVideos(favourites);
          return favourites;
        }
      },
    );
    // try {
    //   return await remoteDataSource.getFavouriteVideos(user: user);
    // } catch (e) {
    //   print('Error fetching favourite videos: $e');
    //   return [];
    // }
  }

  @override
  Future<Either<Failure, bool>> toggleFavouriteVideo({
    required VideoEntity videoEntity,
    required UserEntity userModel,
  }) async {
    return repoManager.call(
      action: () async {
        final result = await remoteDataSource.toggleFavouriteVideo(
          videoEntity: videoEntity,
          userModel: userModel,
        );
        if (result) {
          // final updatedFavourites = await remoteDataSource.getFavouriteVideos(
          //   user: user,
          // );

          await favouritesLocalDataSource.saveFavouriteVideos(
              await remoteDataSource.getFavouriteVideos(user: userModel));
        }
        return result;
      },
    );

    // try {
    //   return await remoteDataSource.toggleFavouriteVideo(
    //     videoId: videoId,
    //     user: user,
    //   );
    // } catch (e) {
    //   print('Error toggling favourite video: $e');
    //   return false;
    //ذ
  }
}
