
import 'package:flutter/material.dart';
import 'package:suits/core/utils/app_text_style.dart';

import '../../../../../core/constant/app_constant.dart';
import 'custom_color.dart';
import 'custom_product_action_buttons.dart';
import 'custom_quantity.dart';
import 'custom_size.dart';

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * .55,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(scafoldColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text("Female Style", style: AppTextStyles.style14RegularGrey),
                  Spacer(),
                  Icon(Icons.star, color: Colors.amber),
                  Text("5.0", style: AppTextStyles.style14RegularGrey),
                ],
              ),
              const SizedBox(height: spacebetweenSections / 2),
              const Text(
                'Classic Blazer',
                style: AppTextStyles.style20BoldBlack,
              ),
              const SizedBox(height: spacebetweenSections / 1.5),
              const Text(
                'Product Details',
                style: AppTextStyles.style16SemiBoldBlack,
              ),
              const SizedBox(height: spacebetweenSections / 3),
              const Text(
                'Cotton sweat shirt with a text print',
                style: AppTextStyles.style15SemiBoldGrey,
              ),
              const SizedBox(height: spacebetweenSections / 2),
              const CustomQuantity(),
              const SizedBox(height: spacebetweenSections),
              Divider(thickness: 2, color: Colors.grey.shade400),
              const Row(
                children: [
                  Text('Color:', style: AppTextStyles.style16SemiBoldBlack),
                  Expanded(child: CustomColor()),
                ],
              ),
              const SizedBox(height: spacebetweenSections / 2),
              const Row(
                children: [
                  Text('Size:', style: AppTextStyles.style16SemiBoldBlack),
                  SizedBox(width: 8),
                  Expanded(child: CustomSize()),
                ],
              ),
              const SizedBox(height: spacebetweenSections / 2),
              const ProductActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
