import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class CustomQuantity extends StatefulWidget {
  const CustomQuantity({super.key});

  @override
  State<CustomQuantity> createState() => _CustomQuantityState();
}

class _CustomQuantityState extends State<CustomQuantity> {
  final ValueNotifier<int> quantity = ValueNotifier<int>(1);

  @override
  void dispose() {
    quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Quantity', style: AppTextStyles.style16SemiBoldBlack),
        const SizedBox(width: spacebetweenSections),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 2,
              vertical: 2,
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: quantity,
              builder: (context, currentQuantity, _) {
                return Row(
                  children: [
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        if (currentQuantity > 1) {
                          quantity.value--;
                        }
                      },
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "$currentQuantity",
                      style: AppTextStyles.style16BoldBlack3,
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        quantity.value++;
                      },
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 12),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
