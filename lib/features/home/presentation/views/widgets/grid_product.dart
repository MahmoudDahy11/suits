import 'package:flutter/material.dart';
import 'package:suits/core/utils/home_assets.dart';

import 'card_item.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key});
  final List<String> images = const [
    HomeAssets.homeHomeS1,
    HomeAssets.homeHomeS2,
    HomeAssets.homeHomeS3,
    HomeAssets.homeHomeS4,
    HomeAssets.homeHomeS5,
    HomeAssets.homeHomeS6,
    HomeAssets.homeHomeS7,
    HomeAssets.homeHomeS8,
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 24,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return CardItem(image: images[index] , onTap: () {
          
        },);
      },
    );
  }
}
