import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerGridViewWidget extends StatelessWidget {
  const CustomShimmerGridViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: _gridDelegate(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 300, // Match the image height
              color: Colors.white,
            ),
          );
        },
      ),
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
