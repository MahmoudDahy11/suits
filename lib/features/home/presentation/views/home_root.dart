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
import 'package:suits/features/home/presentation/views/widgets/bottom_nav_badges.dart';
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
    getIt<FavoriteCubit>().loadFavorites();
    getIt<CartCubit>().loadCart();

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
    controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FavoriteCubit>()),
        BlocProvider.value(value: getIt<CartCubit>()),
      ],
      child: Scaffold(
        backgroundColor: const Color(scafoldColor),
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: screens,
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CartBadgeIcon(icon: Icon(Icons.shopping_cart_outlined)),
              activeIcon: CartBadgeIcon(icon: Icon(Icons.shopping_cart)),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: FavoriteBadgeIcon(icon: Icon(Icons.favorite_border)),
              activeIcon: FavoriteBadgeIcon(icon: Icon(Icons.favorite)),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
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
