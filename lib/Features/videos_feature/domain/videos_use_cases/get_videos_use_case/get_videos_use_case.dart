import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';

import '../../../../../core/managers/error_manager/failure.dart';

class GetVideosUseCase {
  final VideosRepo videosRepository;

  GetVideosUseCase({required this.videosRepository});

  Future<Either<Failure, List<VideoModel>>> call() async {
    return await videosRepository.getVideos();
  }
}
