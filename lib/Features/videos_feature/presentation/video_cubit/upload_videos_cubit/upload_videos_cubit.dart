import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

part 'upload_videos_state.dart';

class UploadVideosCubit extends Cubit<UploadVideosState> {
  final UploadVideoUseCase uploadVideoUseCase;

  UploadVideosCubit({
    required this.uploadVideoUseCase,
  }) : super(UploadVideosState());

  static UploadVideosCubit get(context) => BlocProvider.of(context);

  Future<void> uploadVideo({
    required VideoModel videoModel,
    UserEntity? sharedBy,
  }) async {
    emit(VideoUploadLoadingState());

    final result = await uploadVideoUseCase.call(
        videoModel: videoModel, sharedBy: sharedBy);

    result.fold(
      (failure) {
        print('Error uploading video: ${failure.message}');
        emit(VideoUploadErrorState(message: failure.message));
      },
      (video) => emit(
        VideoUploadedSuccessState(
          videoEntity: video,
        ),
      ),
    );
  }

  Future<void> pickVideo() async {
    emit(VideoPickedLoading());
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowCompression: true,
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        emit(VideoPickedSuccess(file: file));
      } else {
        emit(VideoPickedError(message: 'No file selected'));
      }
    } catch (e) {
      emit(VideoPickedError(message: e.toString()));
    }
  }
}
