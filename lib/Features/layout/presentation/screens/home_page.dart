// my_home_page.dart

import 'package:flutter/material.dart';
import 'package:shorts/Features/layout/presentation/screens/choose_video_page.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';

import '../../../videos_feature/presentation/screens/video_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

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
                    context: context, screen: ChooseVideoPage());
              },
              child: const Text('upload viedo'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                    context: context, screen: VideoPage());
              },
              child: const Text('Videos'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     NavigationManager.navigateTo(
            //         context: context, screen: FavouritesPage());
            //   },
            //   child: const Text('Favourites'),
            // ),
          ],
        ));
  }
}
