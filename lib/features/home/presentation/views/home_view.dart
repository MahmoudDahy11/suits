import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/features/home/presentation/views/widgets/custom_home_app_bar.dart';

import 'widgets/card_item.dart';
import 'widgets/category_text.dart';
import 'widgets/list_view_category.dart';
import 'widgets/list_view_category_text.dart';
import 'widgets/new_collection_card.dart';
import 'package:suits/core/utils/home_assets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(scafoldColor),
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomHomeAppBar(),
                      const SizedBox(height: spacebetweenSections / 2),
                      const NewCollectionCard(),
                      const SizedBox(height: spacebetweenSections),
                      Categorytext(onTap: () {}),
                      const SizedBox(height: spacebetweenSections / 2),
                      const ListViewCategory(),
                      const SizedBox(height: spacebetweenSections),
                      const Text(
                        'Flash Sale',
                        style: AppTextStyles.style20BoldBlack3,
                      ),
                      const SizedBox(height: spacebetweenSections),
                      const ListViewCategoryText(),
                      const SizedBox(height: spacebetweenSections),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CardItem(
                      image: images[index],
                      onTap: () {
                        context.go(itemDetailsView);
                      },
                    );
                  }, childCount: images.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
