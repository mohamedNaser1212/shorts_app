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

      backgroundColor: Colors.black, // Set background color to black
      currentIndex: widget.state.layoutModel.currentIndex,
      items: widget.state.layoutModel.bottomNavigationBarItems,
      selectedItemColor: Colors.black, // Set selected icon color to white
      unselectedItemColor:
          Colors.grey, // Set unselected icon color to a softer white
      onTap: (index) {
        widget.state.setState(() {
          widget.state.layoutModel.changeScreen(index);
        });
      },
    );
  }
}
