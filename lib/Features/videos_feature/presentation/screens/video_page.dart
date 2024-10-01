import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_page_view_widget.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_title.dart';
import '../../../favourites_feature/presentation/cubit/favourites_cubit.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Videos',
      ),
      body: BlocConsumer<UserInfoCubit, UserInfoState>(
        listener: _userInfoListener,
        builder: (context, state) {
          return BlocConsumer<FavouritesCubit, FavouritesState>(
            listener: _favouritesListener,
            builder: (context, state) {
              return BlocConsumer<VideoCubit, VideoState>(
                listener: _videosListener,
                builder: _videosBuilder,
              );
            },
          );
        },
      ),
    );
  }

  Widget _videosBuilder(context, state) {
    if (state is GetVideoSuccess) {
      return VideosPageViewWidget(
        state: state,
      );
    } else if (state is VideoUploadErrorState) {
      return Center(
        child: CustomTitle(
          title: state.message,
          style: TitleStyle.style20,
        ),
      );
    }
    return const Center(
      child: CustomTitle(
        title: 'No data available',
        style: TitleStyle.styleBold20,
      ),
    );
  }

  void _videosListener(context, state) {
    if (state is GetVideoLoading) {
      const Center(child: CircularProgressIndicator());
    }
  }

  void _favouritesListener(context, state) {}

  void _userInfoListener(context, UserState) {
    if (UserState is GetUserInfoSuccessState) {
      UserInfoCubit.get(context).userModel = UserModel(
        id: UserState.userEntity?.id,
        name: UserState.userEntity!.name,
        email: UserState.userEntity!.email,
        phone: UserState.userEntity!.phone,
        fcmToken: UserState.userEntity!.fcmToken,
      );
      print(UserState.userEntity?.name);
    }
  }
}
