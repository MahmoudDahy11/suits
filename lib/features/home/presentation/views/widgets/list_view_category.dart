import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/categort_assets.dart';

class ListViewCategory extends StatelessWidget {
  const ListViewCategory({super.key, this.onTap});
  final List<String> categories = const [
    CategoryAssets.categoryBlazer,
    CategoryAssets.categoryShirt,
    CategoryAssets.categoryMenShoes,
    CategoryAssets.categoryWomanShoes,
    CategoryAssets.categoryBlazer,
    CategoryAssets.categoryShirt,
  ];
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(primaryColor),
                    width: 1.8,
                  ),
                ),
                child: Image.asset(categories[index]),
              ),
            );
          },
          itemCount: categories.length,
        ),
      ),
    );
  }
}
