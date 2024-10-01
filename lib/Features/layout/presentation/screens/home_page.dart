import 'package:flutter/material.dart';
import 'package:shorts/Features/layout/presentation/widgets/home_screen_body.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.currentUser});
  final UserEntity currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shorts'),
        backgroundColor: ColorController.blueAccent,
      ),
      body: HomeScreenBody(
        currentUser: currentUser,
      ),
    );
  }
}
