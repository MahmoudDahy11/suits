import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/features/cart/domain/entity/cart_item_entity.dart';
import 'package:suits/features/home/domain/entity/product_entity.dart';
import 'package:suits/features/cart/presentation/cubits/cart/cart_cubit.dart';

class ProductActionButtons extends StatefulWidget {
  final ProductEntity product;
  const ProductActionButtons({super.key, required this.product});

  @override
  State<ProductActionButtons> createState() => _ProductActionButtonsState();
}

class _ProductActionButtonsState extends State<ProductActionButtons> {
  final ValueNotifier<bool> check = ValueNotifier<bool>(false);

  @override
  void dispose() {
    check.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(scafoldColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(primaryColor), width: 2),
              ),
              child: IconButton(
                onPressed: () {
                  check.value = !check.value;
                  context.pop();
                },
                icon: ValueListenableBuilder<bool>(
                  valueListenable: check,
                  builder: (context, isFavorite, _) {
                    return Icon(
                      isFavorite ? Icons.home : CupertinoIcons.home,
                      color: const Color(primaryColor),
                      size: 30,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: spacebetweenSections),
            Expanded(
              child: CustomButton(
                text: 'Add To Cart',
                onTap: () {
                  final item = CartItemEntity(
                    product: widget.product,
                    quantity: 1,
                  );
                  context.read<CartCubit>().addProduct(item);

                  showSnakBar(context, 'Added to Cart!🛒');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
