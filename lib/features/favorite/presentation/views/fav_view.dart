import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import '../cubits/favorite/favorite_cubit.dart';
import 'widgets/grid_product.dart';
import 'widgets/list_view_category_text_fav.dart';

class FavView extends StatefulWidget {
  const FavView({super.key});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        context.read<FavoriteCubit>().loadFavorites();
      }
    });
  }

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
