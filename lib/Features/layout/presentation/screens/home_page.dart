// my_home_page.dart

import 'package:flutter/material.dart';
import 'package:shorts/Features/layout/presentation/screens/choose_video_page.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../favourites_feature/presentation/screens/favourites_screen.dart';
import '../../../videos_feature/presentation/screens/video_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.currentUser}) : super(key: key);
  final UserEntity currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FCM Notifications Receiver'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                    context: context, screen: const ChooseVideoPage());
              },
              child: const Text('upload viedo'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                    context: context, screen: const VideoPage());
              },
              child: const Text('Videos'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                    context: context,
                    screen: FavouritesPage(
                      currentUser: currentUser,
                    ));
              },
              child: const Text('Favourites'),
            ),
          ],
        ));
  }
}
