import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

import 'widgets/grid_product.dart';
import 'widgets/list_view_category_text_fav.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: Color(scafoldColor),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "My Wishlist",
                    style: AppTextStyles.style20BoldBlack,
                  ),
                ),
                SizedBox(height: spacebetweenSections),
                ListViewCategoryTextFav(),
                SizedBox(height: spacebetweenSections),
                Expanded(child: GridProduct()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
