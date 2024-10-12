import 'package:flutter/material.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';

class FavouritesPageElevatedButton extends StatelessWidget {
  const FavouritesPageElevatedButton({
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
