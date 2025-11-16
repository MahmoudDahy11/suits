import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/features/home/domain/entity/product_entity.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.onTap, required this.productEntity});
  final VoidCallback onTap;
  final ProductEntity productEntity;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final ValueNotifier<bool> _isCheckNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isCheckNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    imageUrl: widget.productEntity.urls.full,
                    fit: BoxFit.cover,
                    cacheKey: widget.productEntity.id,
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
                          onPressed: () => _isCheckNotifier.value = !isCheck,
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
                  widget.productEntity.slug,
                  style: AppTextStyles.style16BoldBlack3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Text('4.9', style: AppTextStyles.style12RegularGrey),
            ],
          ),
          const SizedBox(height: 4.0),
          const Text(r'$83.97', style: AppTextStyles.style14RegularGrey),
        ],
      ),
    );
  }
}
