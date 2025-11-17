import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:suits/features/favorite/domain/entity/fav_item_entity.dart';
import '../../../domain/entity/product_entity.dart';

class CardItem extends StatelessWidget {
  final ProductEntity productEntity;
  final VoidCallback onTap;

  const CardItem({super.key, required this.productEntity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final product = productEntity;
    final itemToToggle = FavoriteItemEntity(product: product);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: product.urls.full,
                    fit: BoxFit.cover,
                    cacheKey: product.id,
                    placeholder: (context, url) => Skeletonizer(
                      effect: ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                      ),
                      child: Container(color: Colors.grey.shade300),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100.withOpacity(0.7),
                    ),
                    child: BlocBuilder<FavoriteCubit, FavoriteState>(
                      builder: (context, state) {
                        final isCurrentlyFavorite = context
                            .read<FavoriteCubit>()
                            .isFavorite(product.id);

                        return IconButton(
                          onPressed: () {
                            context.read<FavoriteCubit>().toggleFavorite(
                              itemToToggle,
                            );
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: isCurrentlyFavorite
                                ? const Color(primaryColor)
                                : Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Flexible(
                child: Text(
                  product.slug,
                  style: AppTextStyles.style16BoldBlack3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              Text(
                product.likes.toString(),
                style: AppTextStyles.style12RegularGrey,
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          const Text(r'$83.97', style: AppTextStyles.style14RegularGrey),
        ],
      ),
    );
  }
}
