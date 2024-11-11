import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';

import '../../../../../core/managers/error_manager/failure.dart';
import '../../video_entity/video_entity.dart';

class GetVideosUseCase {
  final VideosRepo videoRepository;

  GetVideosUseCase({required this.videoRepository});

  Future<Either<Failure, List<VideoEntity>>> call({
    num page = 1,
    num limit = 2, // Changed default limit for better pagination
  }) {
    return videoRepository.getVideos(page: page, pageSize: limit);
  }
}
