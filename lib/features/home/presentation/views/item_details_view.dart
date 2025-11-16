import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'widgets/icon_arrow_back.dart';
import 'widgets/product_details_sheet.dart';
import 'package:suits/features/home/domain/entity/product_entity.dart';

class ItemDetailsView extends StatelessWidget {
  final ProductEntity product;
  const ItemDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              product.urls.full,
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height * .6,
            ),
          ),
          IconArrowBack(
            onTap: () {
              context.pop();
            },
          ),
          ProductDetailsSheet(productEntity: product),
        ],
      ),
    );
  }
}
