
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';

class ProductCartItem extends StatefulWidget {
  const ProductCartItem({super.key});

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  final ValueNotifier<int> quantity = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * .25,
          decoration: const BoxDecoration(color: Color(scafoldColor)),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(Assets.imagesSuit1, fit: BoxFit.fill),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          const Text(
                            'Classic Blazar',
                            style: AppTextStyles.style20BoldBlack,
                          ),
                          const SizedBox(height: spacebetweenSections),
                          const Text(
                            'Size : xl',
                            style: AppTextStyles.style14RegularGrey,
                          ),
                          const SizedBox(height: spacebetweenSections / 2),
                          Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  r'$83.97',
                                  style: AppTextStyles.style12RegularGrey,
                                ),
                                const Spacer(),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      if (quantity.value > 1) {
                                        quantity.value--;
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ValueListenableBuilder(
                                  valueListenable: quantity,
                                  builder: (context, value, _) {
                                    return Text(
                                      '$value',
                                      style: AppTextStyles.style20BoldBlack3,
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(primaryColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      quantity.value++;
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
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
              Divider(color: Colors.grey.shade500, thickness: 1.5),
            ],
          ),
        ),
      ],
    );
  }
}
