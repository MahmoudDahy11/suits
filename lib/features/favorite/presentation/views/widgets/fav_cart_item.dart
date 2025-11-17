import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/constant/app_constant.dart';
import '../../../../favorite/domain/entity/fav_item_entity.dart';

class FavoriteCardItem extends StatefulWidget {
  const FavoriteCardItem({
    super.key,
    required this.onTap,
    required this.favoriteItemEntity,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final VoidCallback onTap;
  final FavoriteItemEntity favoriteItemEntity;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  State<FavoriteCardItem> createState() => _FavoriteCardItemState();
}

class _FavoriteCardItemState extends State<FavoriteCardItem> {
  late final ValueNotifier<bool> _isCheckNotifier;

  @override
  void initState() {
    super.initState();
    _isCheckNotifier = ValueNotifier<bool>(widget.isFavorite);
  }

  @override
  void dispose() {
    _isCheckNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.favoriteItemEntity.product;

    return GestureDetector(
      onTap: widget.onTap,
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
                      color: Colors.grey.shade100.withValues(alpha: .7),
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isCheckNotifier,
                      builder: (context, isCheck, child) {
                        return IconButton(
                          onPressed: () {
                            _isCheckNotifier.value = !isCheck;
                            widget.onToggleFavorite();
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: isCheck
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
          const Text('\$83.97', style: AppTextStyles.style14RegularGrey),
        ],
      ),
    );
  }
}
