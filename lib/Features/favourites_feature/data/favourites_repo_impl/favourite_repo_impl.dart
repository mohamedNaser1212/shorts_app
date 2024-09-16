import 'package:dartz/dartz.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_data_source/favourites_remote_data_source.dart';
import 'package:shorts/core/error_manager/failure.dart';
import 'package:shorts/core/repo_manager/repo_manager.dart';

import '../../../videos_feature/data/model/video_model.dart';
import '../../domain/favourites_repo/favourites_repo.dart';

/// Repository Interface for Videos

/// Repository Implementation for Videos
class FavouritesRepoImpl implements FavouritesRepo {
  final FavouritesRemoteDataSource remoteDataSource;
  final RepoManager repoManager;

  FavouritesRepoImpl({
    required this.remoteDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, List<VideoModel>>> getFavouriteVideos() async {
    return repoManager.call(action: () async {
      final favourites = await remoteDataSource.getFavouriteVideos();

      return favourites;
    });

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
    return repoManager.call(action: () async {
      final isFavourite = await remoteDataSource.toggleFavouriteVideo(
        videoId: videoId,
      );

      return isFavourite;
    });

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
