import 'package:flutter/widgets.dart';
import 'package:shorts/Features/layout/presentation/widgets/choose_video_page_elevated_botton.dart';
import 'package:shorts/Features/layout/presentation/widgets/favourites_page_elevated_botton.dart';
import 'package:shorts/Features/layout/presentation/widgets/videos_page_elevated_botton.dart';

import 'edit_profile_page_elevated_botton.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ChooseVideoPage(),
          SizedBox(height: 20),
          VideoPageElevatedButton(),
          SizedBox(height: 20),
          FavouritesPageElevatedButton(),
          SizedBox(height: 20),
          EditProfilePageElevatedButton(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
