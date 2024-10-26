import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/shared_videos_use_case/shared_videos_use_case.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

part 'share_videos_state.dart';

class ShareVideosCubit extends Cubit<ShareVideosState> {
  ShareVideosCubit({
    required this.shareVideoUseCase
  }) : super(ShareVideosState());

  static ShareVideosCubit get(context) => BlocProvider.of(context);
  final ShareVideoUseCase shareVideoUseCase;

    Future<void> shareVideo({
    required VideoModel videoModel,
    required String text,
    required UserEntity user,
  }) async {
    emit(ShareVideoLoadingState());

    final result = await shareVideoUseCase.call(
      model: videoModel,
      text: text,
      user: user,
    );

    result.fold(
      (failure) {
        print('Error sharing video: ${failure.message}');
        emit(ShareVideoErrorState(message: failure.message));
      },
      (_) => emit(ShareVideoSuccessState()),
    );
  }

}
