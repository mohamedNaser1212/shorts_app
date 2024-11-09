import 'package:flutter/material.dart';
import 'package:shorts/Features/search/presentation/widgets/search_screen_body.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';

class DummySearchField extends StatelessWidget {
  const DummySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SearchScreenBody(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var opacityTween = Tween(begin: 0.0, end: 1.0).animate(animation);

              return FadeTransition(
                opacity: opacityTween,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: ColorController.purpleColor,
            width: 2.0,
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              color: ColorController.whiteColor,
            ),
            SizedBox(width: 8.0),
            Text(
              'Search...',
              style: TextStyle(
                color: ColorController.whiteColor,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
