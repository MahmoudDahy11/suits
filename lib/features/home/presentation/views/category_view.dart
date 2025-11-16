import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/secret/secret.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/features/home/presentation/cubits/get_product/get_product_cubit.dart';
import 'package:suits/features/home/presentation/views/widgets/card_item.dart';

import '../../domain/entity/product_entity.dart';

class CategoryView extends StatefulWidget {
  final String categoryQuery;

  const CategoryView({super.key, required this.categoryQuery});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    context.read<GetProductCubit>().getProducts(
      queryParameters: {
        'query': widget.categoryQuery,
        'client_id': clientIdApi,
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductCubit, GetProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        if (state is GetProductSuccess) products = state.products;
        return Scaffold(
          backgroundColor: const Color(scafoldColor),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  CustomAppBar(
                    title: widget.categoryQuery.toUpperCase(),
                    onTap: context.pop,
                  ),
                  const SizedBox(height: spacebetweenSections / 2),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 24,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (context, index) {
                        return CardItem(
                          onTap: () {
                            context.push(
                              itemDetailsView,
                              extra: products[index],
                            );
                          },
                          productEntity: products[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
