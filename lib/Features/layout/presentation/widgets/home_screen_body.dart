import 'package:flutter/widgets.dart';
import 'package:shorts/Features/layout/presentation/widgets/choose_video_page_elevated_botton.dart';
import 'package:shorts/Features/layout/presentation/widgets/favourites_page_elevated_botton.dart';
import 'package:shorts/Features/layout/presentation/widgets/videos_page_elevated_botton.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
    required this.currentUser,
  });

  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ChooseVideoPageElevatedBotton(),
          const SizedBox(height: 20),
          const VideoPageElevatedBotton(),
          const SizedBox(height: 20),
          FavouritesPageElevatedBotton(currentUser: currentUser),
        ],
      ),
    );
  }
}
