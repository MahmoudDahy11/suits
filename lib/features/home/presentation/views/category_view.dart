import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/secret/secret.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/features/home/presentation/cubits/get_product/get_product_cubit.dart';
import '../../data/models/product_model.dart';
import 'widgets/card_item.dart';
import '../../domain/entity/product_entity.dart';
import 'package:suits/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';

class CategoryView extends StatefulWidget {
  final String categoryQuery;

  const CategoryView({super.key, required this.categoryQuery});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    context.read<GetProductCubit>().getProducts(
      queryParameters: {
        'query': widget.categoryQuery,
        'client_id': clientIdApi,
      },
    );
    context.read<FavoriteCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductCubit, GetProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        if (state is GetProductSuccess) products = state.products;

        final bool isLoading = state is GetProductLoading;
        final int itemCount = isLoading ? 6 : products.length;

        return Scaffold(
          backgroundColor: const Color(scafoldColor),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  CustomAppBar(
                    title: widget.categoryQuery.toUpperCase(),
                    onTap: () {
                      context.pop();
                    },
                  ),
                  const SizedBox(height: spacebetweenSections / 2),
                  if (state is GetProductFailure)
                    Expanded(
                      child: Center(
                        child: Text(
                          state.errMessage,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, favState) {
                          return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            cacheExtent: 1000.0,
                            itemCount: itemCount,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 24,
                                  childAspectRatio: 0.7,
                                ),
                            itemBuilder: (context, index) {
                              final ProductEntity product;
                              if (isLoading) {
                                product = ProductEntity(
                                  id: index.toString(),
                                  slug: 'Product Name Skeleton',
                                  urls: Urls(
                                    full: '',
                                    raw: '',
                                    regular:
                                        'https://placehold.co/400x600/CCCCCC/AAAAAA/png?text=Loading',
                                    small: '',
                                    thumb: '',
                                    smallS3: '',
                                  ),
                                  userName: 'User Skeleton',
                                  likes: 0,
                                );
                              } else {
                                product = products[index];
                              }

                              return Skeletonizer(
                                enabled: isLoading,
                                effect: ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                ),
                                child: CardItem(
                                  productEntity: product,
                                  onTap: isLoading
                                      ? () {}
                                      : () {
                                          context.push(
                                            itemDetailsView,
                                            extra: product,
                                          );
                                        },
                                ),
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
      },
    );
  }
}
