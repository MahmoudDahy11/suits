
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/widgets/custom_button.dart';

class ProductActionButtons extends StatefulWidget {
  const ProductActionButtons({super.key});

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
                },
                icon: ValueListenableBuilder<bool>(
                  valueListenable: check,
                  builder: (context, isFavorite, _) {
                    return Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: const Color(primaryColor),
                      size: 30,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: spacebetweenSections),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .7,
              child: CustomButton(text: 'Add To Cart', onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
