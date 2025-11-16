import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/service/get_it.dart';
import 'package:suits/features/auth/presentation/cubits/signout_cubit/signout_cubit.dart';
import 'package:suits/features/cart/presentation/views/cart_view.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
