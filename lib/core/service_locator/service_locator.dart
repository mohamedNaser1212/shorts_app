import 'package:get_it/get_it.dart';
import 'package:shorts/Features/videos_feature/data/video_remote_data_source/videos_rermote_data_source.dart';
import 'package:shorts/Features/videos_feature/data/videos_repo_impl/videos_repo_impl.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/internet_manager/internet_manager.dart';
import 'package:shorts/core/internet_manager/internet_manager_impl.dart';
import 'package:shorts/core/network/Hive_manager/hive_helper.dart';
import 'package:shorts/core/network/Hive_manager/hive_manager.dart';

final getIt = GetIt.instance;

Future<void> setUpServiceLocator() async {
  // Register dependencies in the correct order
  getIt.registerSingleton<InternetManager>(InternetManagerImpl());

  // Register HiveService
  getIt.registerSingleton<LocalStorageManager>(HiveManager());
  await getIt.get<LocalStorageManager>().initialize();
  print("Hive Initialized");
  getIt.registerFactory<GetVideosUseCase>(
    () => GetVideosUseCase(
      videosRepository: getIt.get<VideosRepo>(),
    ),
  );

  getIt.registerFactory<UploadVideoUseCase>(
    () => UploadVideoUseCase(
      videoRepository: getIt.get<VideosRepo>(),
    ),
  );
  getIt.registerFactory<VideosRepo>(
    () => VideosRepoImpl(
      videosRemoteDataSource: getIt.get<VideosRemoteDataSource>(),
    ),
  );
  // Register Remote Data Source
  getIt.registerSingleton<VideosRemoteDataSource>(
    VideosRemoteDataSourceImpl(),
  );

  // Register Repository

  // Register Use Cases

  // Register Cubit last, after dependencies are registered
  getIt.registerFactory<VideoCubit>(
    () => VideoCubit(
      uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
      getVideosUseCase: getIt.get<GetVideosUseCase>(),
    ),
  );
}
