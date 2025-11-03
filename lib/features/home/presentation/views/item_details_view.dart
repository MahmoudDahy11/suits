import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/home_assets.dart';
import 'widgets/icon_arrow_back.dart';
import 'widgets/product_details_sheet.dart';

class ItemDetailsView extends StatefulWidget {
  const ItemDetailsView({super.key});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
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
            child: Image.asset(
              HomeAssets.homeHomeS5,
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height * .6,
            ),
          ),
          const IconArrowBack(),
          const ProductDetailsSheet(),
        ],
      ),
    );
  }
}
