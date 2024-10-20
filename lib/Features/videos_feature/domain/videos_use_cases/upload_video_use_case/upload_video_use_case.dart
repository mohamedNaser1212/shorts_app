import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../../../core/managers/error_manager/failure.dart';
import '../../video_entity/video_entity.dart';

class UploadVideoUseCase {
  final VideosRepo videoRepository;

  UploadVideoUseCase({required this.videoRepository});

  Future<Either<Failure, VideoEntity>> call({
    required VideoModel videoModel,
    UserEntity? sharedBy,
  }) async {
    return await videoRepository.uploadVideo(videoModel: videoModel,sharedBy: sharedBy);
  }
}
