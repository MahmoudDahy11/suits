
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

import '../../cubits/cart/cart_cubit.dart';

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
