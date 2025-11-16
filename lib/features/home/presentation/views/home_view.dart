import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/secret/secret.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import '../cubits/get_product/get_product_cubit.dart';
import 'widgets/card_item.dart';
import 'widgets/category_text.dart';
import 'widgets/list_view_category.dart';
import 'widgets/list_view_category_text.dart';
import 'widgets/new_collection_card.dart';
import '../../domain/entity/product_entity.dart';
import '../../data/models/product_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _fetchProductsByCategory(String category) {
    String query;
    String orderBy = 'popular';

    switch (category) {
      case 'Newest':
        query = 'suit';
        orderBy = 'latest';
        break;
      case 'Popular':
        query = 'suit';
        orderBy = 'popular';
        break;
      case 'Men':
        query = 'men fashion';
        break;
      case 'Women':
        query = 'women fashion';
        break;
      case 'All':
      default:
        query = 'suit';
        break;
    }

    context.read<GetProductCubit>().getProducts(
      queryParameters: {
        'query': query,
        'client_id': clientIdApi,
        'order_by': orderBy,
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductCubit, GetProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        if (state is GetProductSuccess) products = state.products;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: const Color(scafoldColor),
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                cacheExtent: MediaQuery.of(context).size.height * 2,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomHomeAppBar(),
                          const SizedBox(height: spacebetweenSections / 2),
                          const NewCollectionCard(),
                          const SizedBox(height: spacebetweenSections),
                          Categorytext(onTap: () {}),
                          const SizedBox(height: spacebetweenSections / 2),
                          const ListViewCategory(),
                          const SizedBox(height: spacebetweenSections),
                          const Text(
                            'Flash Sale',
                            style: AppTextStyles.style20BoldBlack3,
                          ),
                          const SizedBox(height: spacebetweenSections),
                          ListViewCategoryText(
                            onCategorySelected: _fetchProductsByCategory,
                          ),
                          const SizedBox(height: spacebetweenSections),
                        ],
                      ),
                    ),
                  ),
                  if (state is GetProductLoading || state is GetProductSuccess)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 24,
                              childAspectRatio: 0.7,
                            ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = state is GetProductSuccess
                                ? products[index]
                                : ProductEntity(
                                    id: '',
                                    slug: '',
                                    urls: Urls(
                                      full: '',
                                      raw: '',
                                      regular: '',
                                      small: '',
                                      thumb: '',
                                      smallS3: '',
                                    ),
                                    userName: '',
                                    likes: 0,
                                  );

                            return Skeletonizer(
                              enabled: state is GetProductLoading,
                              effect: ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                              ),
                              child: CardItem(
                                productEntity: product,
                                onTap: state is GetProductSuccess
                                    ? () {
                                        context.push(
                                          itemDetailsView,
                                          extra: product,
                                        );
                                      }
                                    : () {},
                              ),
                            );
                          },
                          childCount: state is GetProductSuccess
                              ? products.length
                              : 6,
                        ),
                      ),
                    )
                  else if (state is GetProductFailure)
                    SliverToBoxAdapter(
                      child: Center(child: Text(state.errMessage)),
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
