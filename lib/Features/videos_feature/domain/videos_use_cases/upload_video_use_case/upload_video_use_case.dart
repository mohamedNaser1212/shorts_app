import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/error_manager/failure.dart';

class UploadVideoUseCase {
  final VideosRepo videoRepository;

  UploadVideoUseCase({required this.videoRepository});

  Future<Either<Failure, VideoModel>> call({
    required String description,
    required String videoPath,
  }) async {
    return await videoRepository.uploadVideo(
      description: description,
      videoPath: videoPath,
    );
  }
}
