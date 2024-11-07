import 'package:flutter/material.dart';
import 'package:shorts/Features/search/presentation/widgets/search_screen_body.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          backgroundColor: ColorController.blackColor,
          body: SearchScreenBody()),
    );
  }
}
