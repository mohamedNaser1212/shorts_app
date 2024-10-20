import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../../../core/managers/error_manager/failure.dart';

class ShareVideoUseCase {
  final VideosRepo videoRepository;

  ShareVideoUseCase({required this.videoRepository});

  Future<Either<Failure, void>> call({
    required VideoModel model,
    required String text,
    required UserEntity user,
  }) async {
    return await videoRepository.shareVideo(
      model: model,
      text: text,
      user: user,
    );
  }
}
