import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/add_comments_use_case.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';

import '../../../../core/notification_service/notification_helper.dart';
import '../../../authentication_feature/data/user_model/user_model.dart';
import '../../../comments_feature/domain/comments_use_case/show_comments_use_case.dart';
import '../../../comments_feature/presentation/cubit/comments_cubit.dart';
import '../../domain/video_notifiers/video_notifier.dart';

class VideoIcons extends StatefulWidget {
  const VideoIcons({
    super.key,
    required this.videoProvider,
    required this.videoEntity,
  });

  final VideoController videoProvider;
  final VideoEntity videoEntity;

  @override
  State<VideoIcons> createState() => _VideoIconsState();
}

class _VideoIconsState extends State<VideoIcons> {
  final List<String> _comments = [
    'asdads',
    'adsadsadsadsadsadsadsadsadsadsd',
    'asdddddddd',
    'asdads',
    'adsadsadsadsadsadsadsadsadsadsd',
    'asdddddddd',
    'asdads',
    'adsadsadsadsadsadsadsadsadsadsd',
    'asdddddddd',
    'asdads',
    'adsadsadsadsadsadsadsadsadsadsd',
    'asdddddddd',
  ];

  @override
  void initState() {
    super.initState();
    FavouritesCubit.get(context).getFavourites(
      user: UserInfoCubit.get(context).userEntity as UserModel,
    );
    UserInfoCubit.get(context).getUserData();
    CommentsCubit.get(context).fetchComments(
      videoId: widget.videoEntity.id,
    );
  }

  void _showCommentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final bottomSheetHeight = screenHeight * 0.75;

        return BlocProvider(
          create: (context) => CommentsCubit(
              addCommentsUseCase: getIt.get<AddCommentsUseCase>(),
              getCommentsUseCase: getIt.get<GetCommentsUseCase>()),
          child: SizedBox(
            height: bottomSheetHeight,
            child: Padding(
              padding: EdgeInsets.only(
                left: 32.0,
                right: 16.0,
                bottom: keyboardHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTitle(
                    title: 'Comments',
                    style: TitleStyle.styleBold18,
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: ListView.builder(
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_comments[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your comment',
                          ),
                          onSubmitted: (comment) {},
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            CommentsCubit.get(context).addComment(
                              videoId: widget.videoEntity.id,
                              comment: 'Comment',
                              user: UserInfoCubit.get(context).userEntity
                                  as UserModel,
                              userId:
                                  UserInfoCubit.get(context).userEntity!.id!,
                              video: widget.videoEntity,
                            );

                            setState(() {
                              _comments.add('Comment');
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        final notificationHelper = GetIt.instance.get<NotificationHelper>();
        final isFavorite =
            FavouritesCubit.get(context).favorites[widget.videoEntity.id] ??
                false;

        return Positioned(
          right: 20,
          bottom: 100,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  FavouritesCubit.get(context).toggleFavourite(
                    videoId: widget.videoEntity.id,
                    user: widget.videoEntity.user,
                    userModel:
                        UserInfoCubit.get(context).userEntity as UserModel,
                  );

                  notificationHelper.sendNotificationToSpecificUser(
                    fcmToken: widget.videoEntity.user.fcmToken,
                    userId: widget.videoEntity.user.id!,
                    title: 'Liked',
                    body: 'Your video has been liked.',
                    context: context,
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: isFavorite ? Colors.red : Colors.grey,
                  radius: 15,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: _showCommentBottomSheet,
                icon: const Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
