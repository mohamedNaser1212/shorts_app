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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        const ChooseVideoPageElevatedBotton(),
        const VideoPageElevatedBotton(),
        FavouritesPageElevatedBotton(currentUser: currentUser),
      ],
    );
  }
}
