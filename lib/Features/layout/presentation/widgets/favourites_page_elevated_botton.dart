import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';

class FavouritesPageElevatedButton extends StatelessWidget {
  const FavouritesPageElevatedButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.favouritesPageButton(
      context: context,
    );
  }
}
