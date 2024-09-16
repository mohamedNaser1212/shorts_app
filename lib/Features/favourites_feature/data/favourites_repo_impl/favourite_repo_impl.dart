import 'package:dartz/dartz.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_data_source/favourites_local_data_source.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_data_source/favourites_remote_data_source.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/core/error_manager/failure.dart';
import 'package:shorts/core/repo_manager/repo_manager.dart';

import '../../domain/favourites_repo/favourites_repo.dart';

/// Repository Interface for Videos

/// Repository Implementation for Videos
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
  Future<Either<Failure, List<FavouritesEntity>>> getFavouriteVideos() async {
    return repoManager.call(
      action: () async {
        final cachedFavourites =
            await favouritesLocalDataSource.getFavouriteVideos();
        if (cachedFavourites.isNotEmpty) {
          return cachedFavourites;
        } else {
          final favourites = await remoteDataSource.getFavouriteVideos();

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
    required String videoId,
  }) async {
    return repoManager.call(
      action: () async {
        final result = await remoteDataSource.toggleFavouriteVideo(
          videoId: videoId,
        );
        if (result) {
          final updatedFavourites = await remoteDataSource.getFavouriteVideos();

          await favouritesLocalDataSource
              .saveFavouriteVideos(updatedFavourites);
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
    //
  }
}
