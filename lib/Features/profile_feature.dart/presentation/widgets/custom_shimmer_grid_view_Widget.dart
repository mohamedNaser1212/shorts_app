import 'package:flutter/material.dart';

class CustomShimmerGridViewWidget extends StatelessWidget {
  const CustomShimmerGridViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      margin: const EdgeInsets.all(8.0),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 12.0,
    );
  }
}
