import 'package:flutter/material.dart';
import 'package:shorts/Features/favourites_feature/presentation/screens/favourites_screen.dart';
import 'package:shorts/Features/layout/presentation/widgets/choose_video_page_elevated_botton.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/video_screen.dart';

class LayoutModel {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const VideosScreen(),
    // CategoriesBody(
    //   isHorizontal: false,
    // ),
    const ChooseVideoPageElevatedButton(),
    const FavouritesScreen(),
    const EditProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.videocam_sharp), label: 'Videos'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined), label: 'Add Video'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.edit_sharp), label: 'Edit Profile'),
  ];

  int get currentIndex => _currentIndex;

  Widget get currentScreen => _screens[_currentIndex];

  List<BottomNavigationBarItem> get bottomNavigationBarItems =>
      _bottomNavigationBarItems;

  void changeScreen(int index) {
    _currentIndex = index;
  }
}
