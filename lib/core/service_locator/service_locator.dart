import 'package:get_it/get_it.dart';
import 'package:shorts/Features/authentication_feature/data/authentication_repo_impl/authentication_repo_impl.dart';
import 'package:shorts/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shorts/Features/authentication_feature/domain/authentication_use_case/sign_out_use_case.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:shorts/Features/comments_feature/data/data_sources/comments_local_data_source.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/comments_count_use_case.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/delete_comment_use_case.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/show_comments_use_case.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_data_source/favourites_local_data_source.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_data_source/favourites_remote_data_source.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_repo/favourites_repo.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_use_case/get_favourites_use_case.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_use_case/toggle_favourites_use_case.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/toggle_favourites_cubit/toggle_favourites_cubit_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/data/repo_impl/update_user_data_repo_impl.dart';
import 'package:shorts/Features/profile_feature.dart/data/repo_impl/user_profile_videos_repo_impl.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/update_user_data_repo.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/update_user_data_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/user_profile_videos_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/search/domain/repo/search_repo.dart';
import 'package:shorts/Features/search/domain/use_case/search_use_case.dart';
import 'package:shorts/Features/search/presentation/cubit/search_cubit.dart';
import 'package:shorts/Features/videos_feature/data/data_sources/video_remote_data_source/videos_rermote_data_source.dart';
import 'package:shorts/Features/videos_feature/data/data_sources/videos_local_data_source/video_local_data_source.dart';
import 'package:shorts/Features/videos_feature/data/videos_repo_impl/videos_repo_impl.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/shared_videos_use_case/shared_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/share_video_cubit/share_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/core/network/Hive_manager/hive_helper.dart';
import 'package:shorts/core/network/Hive_manager/hive_manager.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper_impl.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';
import 'package:shorts/core/user_info/data/user_info_data_sources/user_info_remote_data_source.dart';
import 'package:shorts/core/user_info/domain/user_info_repo/user_info_repo.dart';

import '../../Features/authentication_feature/data/authentication_data_sources/authentication_remote_data_source.dart';
import '../../Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';
import '../../Features/authentication_feature/domain/authentication_use_case/google_sign_in_use_case.dart';
import '../../Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import '../../Features/authentication_feature/presentation/cubit/google_sign_in_cubit/google_sign_in_cubit.dart';
import '../../Features/comments_feature/data/comments_repo_impl/comments_repo_impl.dart';
import '../../Features/comments_feature/data/data_sources/comments_remote_data_source.dart';
import '../../Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';
import '../../Features/comments_feature/domain/comments_use_case/add_comments_use_case.dart';
import '../../Features/favourites_feature/data/favourites_repo_impl/favourite_repo_impl.dart';
import '../../Features/favourites_feature/domain/favourites_use_case/get_favourites_count_use_case.dart';
import '../../Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import '../../Features/profile_feature.dart/data/data_sources/user_profile_remote_data_source/update_user_data_remote_data_source.dart';
import '../../Features/profile_feature.dart/data/data_sources/user_profile_remote_data_source/user_profile_remote_data_source.dart';
import '../../Features/profile_feature.dart/data/data_sources/user_profile_videos_local_data_source/user_profile_videos_local_data_source.dart';
import '../../Features/profile_feature.dart/domain/use_case/check_user_follow.dart';
import '../../Features/profile_feature.dart/domain/use_case/follow_use_case.dart';
import '../../Features/profile_feature.dart/domain/use_case/get_followers_count_use_case.dart';
import '../../Features/profile_feature.dart/domain/use_case/get_followings_count_use_case.dart';
import '../../Features/search/data/data_sources/search_remote_data_source.dart';
import '../../Features/search/data/repo_impl/search_repo_impl.dart';
import '../managers/internet_manager/internet_manager.dart';
import '../managers/internet_manager/internet_manager_impl.dart';
import '../managers/repo_manager/repo_manager.dart';
import '../managers/repo_manager/repo_manager_impl.dart';
import '../notification_service/notification_helper.dart';
import '../notification_service/push_notification_service.dart';
import '../user_info/data/user_info_repo_impl/user_info_repo_impl.dart';
import '../user_info/domain/use_cases/get_user_info_use_case.dart';

final getIt = GetIt.instance;

Future<void> setUpServiceLocator() async {
  getIt.registerSingleton<InternetManager>(InternetManagerImpl());

  getIt.registerSingleton<LocalStorageManager>(HiveManager());
  await getIt.get<LocalStorageManager>().initialize();

  getIt.registerSingleton<FirebaseHelper>(FirebaseHelperImpl());

  getIt.registerSingleton<RepoManager>(RepoManagerImpl(
    internetManager: getIt.get<InternetManager>(),
  ));

  getIt.registerSingleton<VideosRemoteDataSource>(VideosRemoteDataSourceImpl(
    firebaseHelperManager: getIt.get<FirebaseHelper>(),
  ));

  getIt.registerSingleton<NotificationHelper>(PushNotificationService());

  getIt.registerSingleton<VideoLocalDataSource>(VideoLocalDataSourceImpl(
    hiveHelper: getIt.get<LocalStorageManager>(),
  ));

  getIt.registerSingleton<FavouritesRemoteDataSource>(
      FavouritesRemoteDataSourceImpl(
    firebaseHelperManager: getIt.get<FirebaseHelper>(),
  ));
  getIt.registerSingleton<FavouritesLocalDataSource>(
      FavouritesLocalDataSourceImpl(
    hiveHelper: getIt.get<LocalStorageManager>(),
  ));

  getIt.registerSingleton<FavouritesRepo>(FavouritesRepoImpl(
    remoteDataSource: getIt.get<FavouritesRemoteDataSource>(),
    repoManager: getIt.get<RepoManager>(),
    favouritesLocalDataSource: getIt.get<FavouritesLocalDataSource>(),
  ));

  // Register FavouritesUseCase and FavouritesCubit
  getIt.registerFactory<GetFavouritesUseCase>(() => GetFavouritesUseCase(
        favouritesRepo: getIt.get<FavouritesRepo>(),
      ));
  getIt.registerSingleton<GetFavouritesCountUseCase>(GetFavouritesCountUseCase(
    favouritesRepo: getIt.get<FavouritesRepo>(),
  ));
  getIt.registerFactory<ToggleFavouritesUseCase>(() => ToggleFavouritesUseCase(
        favouritesRepo: getIt.get<FavouritesRepo>(),
      ));
  getIt.registerFactory<FavouritesCubit>(() => FavouritesCubit(
        favouritesUseCase: getIt.get<GetFavouritesUseCase>(),
        getFavouritesCountUseCase: getIt.get<GetFavouritesCountUseCase>(),
      ));
  getIt.registerFactory<ToggleFavouritesCubit>(() => ToggleFavouritesCubit(
        favouritesUseCase: getIt.get<ToggleFavouritesUseCase>(),
      ));

  getIt.registerFactory<VideosRepo>(() => VideosRepoImpl(
        videosRemoteDataSource: getIt.get<VideosRemoteDataSource>(),
        videoLocalDataSource: getIt.get<VideoLocalDataSource>(),
        repoManager: getIt.get<RepoManager>(),
      ));

  getIt.registerFactory<GetVideosUseCase>(
      () => GetVideosUseCase(videoRepository: getIt.get<VideosRepo>()));

  getIt.registerFactory<UploadVideoUseCase>(() => UploadVideoUseCase(
        videoRepository: getIt.get<VideosRepo>(),
      ));
  getIt.registerFactory<ShareVideoUseCase>(() => ShareVideoUseCase(
        videoRepository: getIt.get<VideosRepo>(),
      ));

  getIt.registerFactory<VideoCubit>(() => VideoCubit(
        getVideosUseCase: getIt.get<GetVideosUseCase>(),
      ));
  getIt.registerFactory<UploadVideosCubit>(() => UploadVideosCubit(
        uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
      ));
  getIt.registerFactory<ShareVideosCubit>(() => ShareVideosCubit(
        shareVideoUseCase: getIt.get<ShareVideoUseCase>(),
      ));

  getIt.registerSingleton<AuthenticationRemoteDataSource>(
      AuthenticationDataSourceImpl(
    firebaseHelper: getIt.get<FirebaseHelper>(),
  ));

  getIt.registerSingleton<UserLocalDataSourceImpl>(UserLocalDataSourceImpl(
    hiveHelper: getIt.get<LocalStorageManager>(),
  ));

  getIt.registerSingleton<AuthenticationRepo>(AuthRepoImpl(
    repoManager: getIt.get<RepoManager>(),
    loginDataSource: getIt.get<AuthenticationRemoteDataSource>(),
    userInfoLocalDataSourceImpl: getIt.get<UserLocalDataSourceImpl>(),
  ));

  getIt.registerSingleton<CommentsRemoteDataSource>(
    CommentsRemoteDataSourceImpl(
      firebaseHelper: getIt.get<FirebaseHelper>(),
    ),
  );
  getIt.registerSingleton<SearchRemoteDataSource>(
    SearchRemoteDataSourceImpl(
        // firebaseHelper: getIt.get<FirebaseHelper>(),
        ),
  );
  getIt.registerSingleton<CommentsLocalDataSourceImpl>(
    CommentsLocalDataSourceImpl(
      localStorageManager: getIt.get<LocalStorageManager>(),
    ),
  );
  getIt
      .registerSingleton<UserInfoRemoteDataSource>(UserInfoRemoteDataSourceImpl(
    firebaseHelper: getIt.get<FirebaseHelper>(),
  ));
  getIt.registerSingleton<UserProfilesRemoteDataSource>(
    UserProfileVideosRemoteDataSourceImpl(
      firebaseHelper: getIt.get<FirebaseHelper>(),
    ),
  );
  getIt.registerSingleton<UserVideosLocalDataSource>(
    UserVideosLocalDataSourceImpl(
      hiveHelper: getIt.get<LocalStorageManager>(),
    ),
  );
  getIt.registerSingleton<UserProfileRepo>(
    UserProfileRepoImpl(
      repoManager: getIt.get<RepoManager>(),
      remoteDataSource: getIt.get<UserProfilesRemoteDataSource>(),
      localDataSource: getIt.get<UserVideosLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(
      repoManager: getIt.get<RepoManager>(),
      searchRemoteDataSource: getIt.get<SearchRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<UserProfileVideosUseCase>(UserProfileVideosUseCase(
    repository: getIt.get<UserProfileRepo>(),
  ));
  getIt.registerSingleton<SearchUseCase>(SearchUseCase(
    searchRepo: getIt.get<SearchRepo>(),
  ));
  getIt.registerSingleton<ToggleFollowUserUseCase>(ToggleFollowUserUseCase(
    repository: getIt.get<UserProfileRepo>(),
  ));
  // getIt.registerSingleton<UnfollowUserUseCase>(UnfollowUserUseCase(
  //   repository: getIt.get<UserProfileRepo>(),
  // ));
  getIt.registerSingleton<GetFollowersCountUseCase>(GetFollowersCountUseCase(
    repository: getIt.get<UserProfileRepo>(),
  ));
  getIt.registerSingleton<GetFollowingCountUseCase>(GetFollowingCountUseCase(
    repository: getIt.get<UserProfileRepo>(),
  ));
  getIt.registerSingleton<IsUserFollowedUseCase>(IsUserFollowedUseCase(
    repository: getIt.get<UserProfileRepo>(),
  ));

  getIt.registerFactory<GetUserVideosCubit>(
    () => GetUserVideosCubit(
      getUserInfoUseCase: getIt.get<UserProfileVideosUseCase>(),
    ),
  );
  getIt.registerFactory<FollowCubit>(
    () => FollowCubit(
      followUserUseCase: getIt.get<ToggleFollowUserUseCase>(),
      //  unfollowUserUseCase: getIt.get<UnfollowUserUseCase>(),
      getFollowersCountUseCase: getIt.get<GetFollowersCountUseCase>(),
      getFollowingCountUseCase: getIt.get<GetFollowingCountUseCase>(),
      isUserFollowedUseCase: getIt.get<IsUserFollowedUseCase>(),
    ),
  );
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(
      searchUseCase: getIt.get<SearchUseCase>(),
    ),
  );
  getIt.registerSingleton<CommentsRepo>(CommentsRepoImpl(
    repoManager: getIt.get<RepoManager>(),
    commentsRemoteDataSource: getIt.get<CommentsRemoteDataSource>(),
    commentsLocalDataSource: getIt.get<CommentsLocalDataSourceImpl>(),
  ));

  getIt.registerSingleton<UserInfoRepo>(UserInfoRepoImpl(
    userLocalDataSource: getIt.get<UserLocalDataSourceImpl>(),
    remoteDataSource: getIt.get<UserInfoRemoteDataSource>(),
    repoManager: getIt.get<RepoManager>(),
  ));
  getIt.registerFactory<GetUserInfoUseCase>(() => GetUserInfoUseCase(
        userInfoRepo: getIt.get<UserInfoRepo>(),
      ));

  getIt.registerFactory<UserInfoCubit>(() => UserInfoCubit(
        getUserUseCase: getIt.get<GetUserInfoUseCase>(),
        signOutUseCase: getIt.get<SignOutUseCase>(),
      ));
  getIt.registerSingleton<AddCommentsUseCase>(AddCommentsUseCase(
    commentsRepo: getIt.get<CommentsRepo>(),
  ));
  getIt.registerSingleton<GetCommentsCountUseCase>(GetCommentsCountUseCase(
    commentsRepo: getIt.get<CommentsRepo>(),
  ));
  getIt.registerSingleton<GetCommentsUseCase>(GetCommentsUseCase(
    commentsRepo: getIt.get<CommentsRepo>(),
  ));

  getIt.registerSingleton<LoginUseCase>(LoginUseCase(
    authenticationRepo: getIt.get<AuthenticationRepo>(),
  ));
  getIt.registerSingleton<SignOutUseCase>(SignOutUseCase(
    authenticationRepo: getIt.get<AuthenticationRepo>(),
  ));

  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(
    authenticationRepo: getIt.get<AuthenticationRepo>(),
  ));
  getIt.registerSingleton<DeleteCommentUseCase>(DeleteCommentUseCase(
    commentsRepo: getIt.get<CommentsRepo>(),
  ));

  getIt.registerSingleton<UpdateUserDataRemoteDataSource>(
      UpdateUserDataSourceImpl(
    firebaseHelper: getIt.get<FirebaseHelper>(),
  ));
  getIt.registerSingleton<GoogleSignInUseCase>(GoogleSignInUseCase(
    repository: getIt.get<AuthenticationRepo>(),
  ));
  getIt.registerSingleton<UpdateUserDataRepo>(UpdateUserDataRepoImpl(
    repoManager: getIt.get<RepoManager>(),
    updateUserDataSource: getIt.get<UpdateUserDataRemoteDataSource>(),
    userInfoLocalDataSource: getIt.get<UserLocalDataSourceImpl>(),
  ));
  getIt.registerSingleton<UpdateUserDataUseCase>(UpdateUserDataUseCase(
    updateRepo: getIt.get<UpdateUserDataRepo>(),
  ));
  // getIt.registerSingleton<GetCollectionAfterDocUseCase>(
  //     GetCollectionAfterDocUseCase(
  //   commentsRepo: getIt.get<CommentsRepo>(),
  //   //updateRepo: getIt.get<UpdateUserDataRepo>(),
  // ));
  getIt.registerFactory<UpdateUserDataCubit>(() => UpdateUserDataCubit(
        updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
      ));
  getIt.registerFactory<GoogleSignInCubit>(() => GoogleSignInCubit(
        googleSignInUseCase: getIt.get<GoogleSignInUseCase>(),
      ));

  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
        registerUseCase: getIt.get<RegisterUseCase>(),
      ));
  getIt.registerFactory<CommentsCubit>(() => CommentsCubit(
        getCommentsUseCase: getIt.get<GetCommentsUseCase>(),
        getCommentsCountUseCase: getIt.get<GetCommentsCountUseCase>(),
        //  getCollectionAfterDocUseCase: getIt.get<GetCollectionAfterDocUseCase>(),
      ));
  getIt.registerFactory<AddCommentsCubit>(() => AddCommentsCubit(
        addCommentsUseCase: getIt.get<AddCommentsUseCase>(),
        deleteCommentUseCase: getIt.get<DeleteCommentUseCase>(),
      ));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(
        loginUseCase: getIt.get<LoginUseCase>(),
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      ));
}
