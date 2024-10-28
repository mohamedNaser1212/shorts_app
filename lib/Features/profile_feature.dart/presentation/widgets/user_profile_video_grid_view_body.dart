import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_page_view_widget.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/widgets/videos_screen_AppBar.dart';

class UserProfileVideosGridViewBody extends StatelessWidget {
  const UserProfileVideosGridViewBody({
    super.key,
    required this.video,
    required this.videos,
    required this.index,
  });

  final VideoEntity video;
  final List<VideoEntity> videos;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const VideosScreenAppBarWidget(),
        body: GestureDetector(
          onTap: () {
            NavigationManager.navigateTo(
              context: context,
              screen: const VideosPageViewWidget(),
            );
          },
          child: Card(
            elevation: 4.0,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      video.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    video.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
