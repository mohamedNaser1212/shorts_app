import 'package:flutter/material.dart';
import 'package:shorts/Features/favourites_feature/presentation/screens/favourites_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';
import 'package:shorts/core/widgets/reusable_elevated_botton.dart';

class FavouritesPageElevatedBotton extends StatelessWidget {
  const FavouritesPageElevatedBotton({
    super.key,
    required this.currentUser,
  });

  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.favouritesPageBotton(
      context: context,
      currentUser: currentUser,
    );
  }
}