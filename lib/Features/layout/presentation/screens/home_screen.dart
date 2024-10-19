import 'package:flutter/material.dart';
import 'package:shorts/Features/layout/presentation/widgets/home_screen_body.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.currentUser});
  final UserEntity currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Shorts', showLeadingIcon: false,),
      body: HomeScreenBody(
        currentUser: currentUser,
      ),
    );
  }
}
