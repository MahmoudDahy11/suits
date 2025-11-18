import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/features/cart/domain/entity/cart_item_entity.dart';
import '../../cubits/cart/cart_cubit.dart';

class ProductCartItem extends StatelessWidget {
  final CartItemEntity cartItem;
  const ProductCartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    const double itemHeight = 130.0;
    const double imageSize = 100.0;
    const double testPrice = 30.0;

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
                              r'$' + testPrice.toStringAsFixed(2),
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

class QuantityWidget extends StatefulWidget {
  final String productId;
  final int initialQuantity;

  const QuantityWidget({
    super.key,
    required this.productId,
    required this.initialQuantity,
  });

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      selector: (state) {
        return context.read<CartCubit>().getQuantityForProduct(
          widget.productId,
        );
      },
      builder: (context, quantity) {
        final cubit = context.read<CartCubit>();

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 16,
                onPressed: () {
                  cubit.decreaseQuantity(widget.productId);
                },
                icon: const Icon(Icons.remove, color: Colors.black),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 30,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Text(
                    '$quantity',
                    key: ValueKey<int>(quantity),
                    style: AppTextStyles.style16SemiBoldBlack,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 16,
                onPressed: () {
                  cubit.increaseQuantity(widget.productId);
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
