import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/error_manager/failure.dart';

import '../../../../authentication_feature/data/user_model/user_model.dart';
import '../../video_entity/video_entity.dart';

class UploadVideoUseCase {
  final VideosRepo videoRepository;

  UploadVideoUseCase({required this.videoRepository});

  Future<Either<Failure, VideoEntity>> call({
    required String description,
    required String videoPath,
    required UserModel user,
  }) async {
    return await videoRepository.uploadVideo(
      description: description,
      videoPath: videoPath,
      user: user,
    );
  }
}
