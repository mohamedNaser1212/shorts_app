import 'package:shorts/core/network/Hive_manager/hive_helper.dart';

import '../../../../../core/network/Hive_manager/hive_boxes_names.dart';
import '../../domain/favourite_entitiy.dart';

abstract class FavouritesLocalDataSource {
  const FavouritesLocalDataSource();

  Future<List<FavouritesEntity>> getFavouriteVideos();
  Future<void> saveFavouriteVideos(List<FavouritesEntity> favourites);
  Future<void> removeFavouriteVideo(String videoId);
  Future<void> clearFavouriteVideos();
}

class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  final LocalStorageManager hiveHelper;

  const FavouritesLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<List<FavouritesEntity>> getFavouriteVideos() async {
    final favouriteItems = await hiveHelper
        .loadData<FavouritesEntity>(HiveBoxesNames.kFavouritesBox);
    return favouriteItems.cast<FavouritesEntity>().toList();
  }

  @override
  Future<void> saveFavouriteVideos(List<FavouritesEntity> favourites) async {
    await hiveHelper.saveData<FavouritesEntity>(
        favourites, HiveBoxesNames.kFavouritesBox);
  }

  @override
  Future<void> removeFavouriteVideo(String videoId) async {
    final favouriteItems = await getFavouriteVideos();
    final updatedFavouriteItems =
        favouriteItems.where((item) => item.id != videoId).toList();
    await saveFavouriteVideos(updatedFavouriteItems);
  }

  @override
  Future<void> clearFavouriteVideos() async {
    await hiveHelper.clearData<FavouritesEntity>(HiveBoxesNames.kFavouritesBox);
  }
}