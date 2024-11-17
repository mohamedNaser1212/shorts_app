import '../../../../../core/network/Hive_manager/hive_boxes_names.dart';
import '../../../../../core/network/Hive_manager/hive_helper.dart';
import '../../../../videos_feature/domain/video_entity/video_entity.dart';

abstract class UserVideosLocalDataSource {
  const UserVideosLocalDataSource._();

  Future<void> saveUserVideos({required List<VideoEntity> videos});
  Future<List<VideoEntity>?> loadUserVideos();
  Future<void> clearUserVideos();
}

class UserVideosLocalDataSourceImpl implements UserVideosLocalDataSource {
  final LocalStorageManager hiveHelper;

  const UserVideosLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> saveUserVideos({required List<VideoEntity> videos}) async {
    await hiveHelper.saveSingleItem<List<VideoEntity>>(
      HiveBoxesNames.kUserVideosBox,
      videos,
      HiveBoxesNames.kUserVideosBox,
    );
  }

  @override
  Future<List<VideoEntity>?> loadUserVideos() async {
    return await hiveHelper.loadSingleItem<List<VideoEntity>>(
      HiveBoxesNames.kUserVideosBox,
      HiveBoxesNames.kUserVideosBox,
    );
  }

  @override
  Future<void> clearUserVideos() async {
    return await hiveHelper.clearData<List<VideoEntity>>(
      HiveBoxesNames.kUserVideosBox,
    );
  }
}
