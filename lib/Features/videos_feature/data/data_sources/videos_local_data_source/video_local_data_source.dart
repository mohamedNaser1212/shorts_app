import 'package:shorts/core/network/Hive_manager/hive_helper.dart';

import '../../../../../core/network/Hive_manager/hive_boxes_names.dart';
import '../../../domain/video_entity/video_entity.dart';

abstract class VideoLocalDataSource {
  const VideoLocalDataSource();

  Future<List<VideoEntity>> getVideos();
  Future<void> saveVideos(List<VideoEntity> videos);
  Future<void> removeVideo(String videoId);
  Future<void> clearVideos();
}

class VideoLocalDataSourceImpl implements VideoLocalDataSource {
  final LocalStorageManager hiveHelper;

  const VideoLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<List<VideoEntity>> getVideos() async {
    final videoItems =
        await hiveHelper.loadData<VideoEntity>(HiveBoxesNames.kVideoBox);
    return videoItems.cast<VideoEntity>().toList();
  }

  @override
  Future<void> saveVideos(List<VideoEntity> videos) async {
    await hiveHelper.saveData<VideoEntity>(videos, HiveBoxesNames.kVideoBox);
    print('Videos saved');
  }

  @override
  Future<void> removeVideo(String videoId) async {
    final videoItems = await getVideos();
    final updatedVideoItems =
        videoItems.where((item) => item.id != videoId).toList();
    await saveVideos(updatedVideoItems);
  }

  @override
  Future<void> clearVideos() async {
    await hiveHelper.clearData<VideoEntity>(HiveBoxesNames.kVideoBox);
  }
}
