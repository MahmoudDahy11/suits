import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import '../cubits/order_cubit.dart';

class PurchasedProductsView extends StatefulWidget {
  const PurchasedProductsView({super.key});

  @override
  State<PurchasedProductsView> createState() => _PurchasedProductsViewState();
}

class _PurchasedProductsViewState extends State<PurchasedProductsView> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              CustomAppBar(
                title: 'Purchased Products',
                onTap: () => context.go(homeRoot),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OrderFailure) {
                      return Center(child: Text(state.message));
                    } else if (state is OrderLoaded) {
                      if (state.orders.isEmpty) {
                        return const Center(
                          child: Text('No purchased products yet.'),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              leading: Image.network(
                                order.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                              title: Text(order.productName),
                              subtitle: Text(
                                'Purchased on ${order.date.toString().split(' ')[0]}',
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
