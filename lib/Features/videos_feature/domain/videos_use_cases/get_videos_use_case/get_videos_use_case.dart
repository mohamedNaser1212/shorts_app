import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/error_manager/failure.dart';

import '../../video_entity/video_entity.dart';

class GetVideosUseCase {
  final VideosRepo videosRepository;

  GetVideosUseCase({required this.videosRepository});

  Future<Either<Failure, List<VideoEntity>>> call() async {
    return await videosRepository.getVideos();
  }
}
