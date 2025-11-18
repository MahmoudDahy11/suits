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
  late final PageController controller;

  late final List<Widget> screens;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();

    screens = [
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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() => _selectedIndex = index);
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildIconWithBadge(Widget iconWidget, int count) {
    const badgePadding = EdgeInsets.all(2);
    const badgeConstraints = BoxConstraints(minWidth: 16, minHeight: 16);
    const badgeTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        if (count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: badgePadding,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              constraints: badgeConstraints,
              child: Text(
                count.toString(),
                style: badgeTextStyle,
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
        BlocProvider(
          create: (context) {
            final cubit = getIt<FavoriteCubit>();
            cubit.loadFavorites();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = getIt<CartCubit>();

            cubit.loadCart();
            return cubit;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(scafoldColor),
        body: PageView(
          controller: controller,

          physics: const NeverScrollableScrollPhysics(),
          children: screens,

          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(primaryColor),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 10,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: BlocSelector<CartCubit, CartState, int>(
                selector: (state) =>
                    state is CartLoaded ? state.items.length : 0,
                builder: (context, count) {
                  return _buildIconWithBadge(
                    const Icon(Icons.shopping_cart_outlined),
                    count,
                  );
                },
              ),
              activeIcon: BlocSelector<CartCubit, CartState, int>(
                selector: (state) =>
                    state is CartLoaded ? state.items.length : 0,
                builder: (context, count) {
                  return _buildIconWithBadge(
                    const Icon(Icons.shopping_cart),
                    count,
                  );
                },
              ),
              label: 'Cart',
            ),
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
