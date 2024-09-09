import 'package:flutter/material.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';

import '../../../../core/utils/widgets/custom_title.dart';
import '../../../videos_feature/presentation/screens/video_page.dart';
import 'choose_video_page.dart'; // Import the new page

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                  context: context,
                  screen: const ChooseVideoPage(),
                );
              },
              child: const CustomTitle(
                title: 'Select Video',
                style: TitleStyle.style18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                  context: context,
                  screen: const VideoPage(),
                );
              },
              child: const CustomTitle(
                title: 'View Videos',
                style: TitleStyle.style18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
