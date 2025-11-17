import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/service/get_it.dart';
import 'package:suits/features/auth/presentation/cubits/signout_cubit/signout_cubit.dart';
import 'package:suits/features/cart/presentation/cubits/cart/cart_cubit.dart';
import 'package:suits/features/cart/presentation/views/cart_view.dart';
import 'package:suits/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:suits/features/favorite/presentation/views/fav_view.dart';
import 'package:suits/features/home/presentation/cubits/get_product/get_product_cubit.dart';
import 'package:suits/features/home/presentation/views/home_view.dart';
import 'package:suits/features/profile/presentation/views/profile_view.dart';

class HomeRoot extends StatefulWidget {
  const HomeRoot({super.key});

  @override
  State<HomeRoot> createState() => _HomeRootState();
}

class _HomeRootState extends State<HomeRoot> {
  final PageController controller = PageController();

  final List<Widget> screens = [
    BlocProvider(
      create: (context) => getIt<GetProductCubit>(),
      child: const HomeView(),
    ),
    const CartView(),
    const FavView(),
    BlocProvider(
      create: (context) => getIt<SignoutCubit>(),
      child: const ProfileView(),
    ),
  ];

  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => selectedIndex = index);
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildIconWithBadge(Widget iconWidget, int count) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        if (count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<FavoriteCubit>()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: Scaffold(
        backgroundColor: const Color(scafoldColor),
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
          onPageChanged: (index) => setState(() => selectedIndex = index),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(primaryColor),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 10,
          items: [
            // 0: Home Item
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            // 1: Cart Item
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            // 2: Favorite Item with Badge Logic
            BottomNavigationBarItem(
              icon: BlocSelector<FavoriteCubit, FavoriteState, int>(
                selector: (state) =>
                    state is FavoriteLoaded ? state.items.length : 0,
                builder: (context, count) {
                  return _buildIconWithBadge(
                    const Icon(Icons.favorite_border),
                    count,
                  );
                },
              ),
              activeIcon: BlocSelector<FavoriteCubit, FavoriteState, int>(
                selector: (state) =>
                    state is FavoriteLoaded ? state.items.length : 0,
                builder: (context, count) {
                  return _buildIconWithBadge(const Icon(Icons.favorite), count);
                },
              ),
              label: 'Favorite',
            ),
            // 3: Profile Item
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
