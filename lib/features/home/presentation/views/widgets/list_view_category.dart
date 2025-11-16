import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/categort_assets.dart';

class ListViewCategory extends StatelessWidget {
  const ListViewCategory({super.key, this.onTap});

  final List<Map<String, String>> categoriesData = const [
    {'asset': CategoryAssets.categoryBlazer, 'query': 'blazer'},
    {'asset': CategoryAssets.categoryShirt, 'query': 'shirt'},
    {'asset': CategoryAssets.categoryMenShoes, 'query': 'men shoes'},
    {'asset': CategoryAssets.categoryWomanShoes, 'query': 'women shoes'},
  ];

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final categoryItem = categoriesData[index];
            final categoryQuery = categoryItem['query']!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () =>
                    context.push('$categoryView?category=$categoryQuery'),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(primaryColor),
                      width: 1.8,
                    ),
                  ),
                  child: Image.asset(categoryItem['asset']!),
                ),
              ),
            );
          },
          itemCount: categoriesData.length,
        ),
      ),
    );
  }
}
