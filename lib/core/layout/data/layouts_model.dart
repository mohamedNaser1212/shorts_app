import 'package:flutter/material.dart';
import 'package:shorts/Features/layout/presentation/widgets/video_selection_screen.dart';
import 'package:shorts/Features/search/presentation/screens/search_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/video_screen.dart';

import '../../../Features/profile_feature.dart/presentation/screens/user_profile_screen.dart';

class LayoutModel {
  int _currentIndex = 0;

  final List<Widget> screens = [
    const VideosScreen(),
    const VideoSelectionScreen(),
    const SearchScreen(),
    UserProfileScreen(
      showLeadingIcon: false,
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 32,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        size: 32,
      ),
      label: 'Add Short',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.search,
        size: 32,
      ),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 32,
      ),
      label: ' Profile',
    ),
  ];

  int get currentIndex => _currentIndex;

  Widget get currentScreen => screens[_currentIndex];

  List<BottomNavigationBarItem> get bottomNavigationBarItems =>
      _bottomNavigationBarItems;

  void changeScreen(int index) {
    _currentIndex = index;
  }
}
