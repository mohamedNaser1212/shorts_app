// my_home_page.dart

import 'package:flutter/material.dart';
import 'package:shorts/Features/layout/presentation/widgets/choose_video_page_elevated_botton.dart';
import 'package:shorts/Features/layout/presentation/widgets/favourites_page_elevated_botton.dart';
import 'package:shorts/Features/layout/presentation/widgets/videos_page_elevated_botton.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';



class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.currentUser});
  final UserEntity currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shorts'),
          backgroundColor: ColorController.blueAccent,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const ChooseVideoPageElevatedBotton(),
            const VideoPageElevatedBotton(),
            FavouritesPageElevatedBotton(currentUser: currentUser),
          ],
        ));
  }
}





