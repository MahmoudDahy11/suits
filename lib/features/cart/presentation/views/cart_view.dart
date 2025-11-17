import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/core/utils/app_text_style.dart';

import 'widgets/product_cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final ValueNotifier<List<int>> items = ValueNotifier(
    List.generate(8, (index) => index),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const Text('My cards', style: AppTextStyles.style18BoldBlack),
              const SizedBox(height: spacebetweenSections),

              Expanded(
                child: ValueListenableBuilder<List<int>>(
                  valueListenable: items,
                  builder: (context, list, _) {
                    return list.isEmpty
                        ? const Center(
                            child: Text(
                              "The cart is empty",
                              style: AppTextStyles.style18BoldBlack,
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  color: const Color(0xffE8A3A4),
                                  child: const Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  final updated = List<int>.from(list);
                                  updated.removeAt(index);
                                  items.value = updated;

                                  showSnakBar(
                                    context,
                                    'Item dismissed',
                                    isError: true,
                                  );
                                },
                                child: const ProductCartItem(),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
