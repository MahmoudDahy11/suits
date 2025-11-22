import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_button.dart';
import '../cubits/cart/cart_cubit.dart';
import 'widgets/checkout_summary.dart';
import 'widgets/product_cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<CartCubit>().loadCart();
    } else {}
  }

  static const double _defaultPrice = 30.0;
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) {
          final previousCount = previous is CartLoaded
              ? previous.items.length
              : 0;
          final currentCount = current is CartLoaded ? current.items.length : 0;
          return previous is CartLoaded != current is CartLoaded ||
              previousCount != currentCount;
        },
        builder: (context, state) {
          final isCartNotEmpty = state is CartLoaded && state.items.isNotEmpty;

          if (!isCartNotEmpty) {
            return const SizedBox();
          }
          return SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: 'Show Summary',
                onTap: () {
                  _openCheckoutSheet(context, state);
                },
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const Text('My cards', style: AppTextStyles.style18BoldBlack),
              const SizedBox(height: spacebetweenSections),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(
                          radius: 15.0,
                          color: Color(primaryColor),
                        ),
                      );
                    } else if (state is CartLoaded) {
                      final items = state.items;

                      if (items.isEmpty) {
                        return const Center(
                          child: Text(
                            "The cart is empty",
                            style: AppTextStyles.style18BoldBlack,
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final cartItem = items[index];
                          return Dismissible(
                            key: ValueKey(cartItem.product.id),
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
                              cartCubit.removeProduct(cartItem.product.id);
                              showSnakBar(
                                context,
                                'Item dismissed',
                                isError: true,
                              );
                            },
                            child: ProductCartItem(
                              cartItem: cartItem,
                              defaultPrice: _defaultPrice,
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCheckoutSheet(BuildContext context, CartLoaded state) {
    final subTotal = state.items.fold<double>(
      0.0,
      (sum, item) => sum + (_defaultPrice * item.quantity),
    );

    const double discount = 18.00;
    const double deliveryFee = 00.00;

    final totalCost = (subTotal + deliveryFee) - discount;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CheckoutSummary(
            subTotal: subTotal,
            discount: discount,
            deliveryFee: deliveryFee,
            totalCost: totalCost,
          ),
        );
      },
    );
  }
}
