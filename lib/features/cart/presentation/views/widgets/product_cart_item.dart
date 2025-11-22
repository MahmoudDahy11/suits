import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/features/cart/domain/entity/cart_item_entity.dart';
import 'quantity_widget.dart';

class ProductCartItem extends StatelessWidget {
  final CartItemEntity cartItem;
  final double defaultPrice;

  const ProductCartItem({
    super.key,
    required this.cartItem,
    required this.defaultPrice,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    const double itemHeight = 130.0;
    const double imageSize = 100.0;
    return SizedBox(
      height: itemHeight,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.urls.small,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: imageSize / 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.slug,
                        style: AppTextStyles.style20BoldBlack,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: spacebetweenSections / 4),
                      const Text(
                        'Size : xl',
                        style: AppTextStyles.style14RegularGrey,
                      ),
                      const SizedBox(height: spacebetweenSections / 2),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              r'$' + defaultPrice.toStringAsFixed(2),
                              style: AppTextStyles.style16SemiBoldBlack
                                  .copyWith(color: const Color(primaryColor)),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 120,
                              child: QuantityWidget(
                                productId: product.id,
                                initialQuantity: cartItem.quantity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: spacebetweenSections / 2),
          Divider(color: Colors.grey.shade300, thickness: 1.5, height: 0),
          const SizedBox(height: spacebetweenSections / 2),
        ],
      ),
    );
  }
}
