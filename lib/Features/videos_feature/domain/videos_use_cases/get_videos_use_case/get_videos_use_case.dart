import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';

import '../../../../../core/managers/error_manager/failure.dart';
import '../../video_entity/video_entity.dart';

class GetVideosUseCase {
  final VideosRepo videoRepository;

  GetVideosUseCase({required this.videoRepository});

  Future<Either<Failure, List<VideoEntity>>> call() {
    return videoRepository.getVideos();
  }
}
