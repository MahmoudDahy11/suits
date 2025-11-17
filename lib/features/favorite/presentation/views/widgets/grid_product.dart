import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import '../../../../home/presentation/views/widgets/card_item.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteLoaded) {
          final items = state.items;
          if (items.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 24,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final favoriteItem = items[index];

              return CardItem(
                productEntity: favoriteItem.product,

                onTap: () {},
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
