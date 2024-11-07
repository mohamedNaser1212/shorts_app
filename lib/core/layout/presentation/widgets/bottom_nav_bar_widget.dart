import 'package:flutter/material.dart';

import '../screens/layout_widget.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.state,
  });

  final LayoutScreenState state;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type:
          BottomNavigationBarType.fixed, // Set type to fixed for custom colors
      backgroundColor: Colors.black, // Set navigation bar background to black
      currentIndex: widget.state.layoutModel.currentIndex,
      items: widget.state.layoutModel.bottomNavigationBarItems,
      selectedItemColor: Colors.white, // Set selected icon color to white
      unselectedItemColor: Colors.grey, // Set unselected icon color to grey
      onTap: (index) {
        widget.state.setState(() {
          widget.state.layoutModel.changeScreen(index);
        });
      },
    );
  }
}
