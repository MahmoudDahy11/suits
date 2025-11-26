import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suits/features/cart/presentation/cubits/cart/cart_cubit.dart';
import 'package:suits/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';

class CartBadgeIcon extends StatelessWidget {
  const CartBadgeIcon({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      selector: (state) => state is CartLoaded ? state.items.length : 0,
      builder: (context, count) {
        return _BadgeIcon(icon: icon, count: count);
      },
    );
  }
}

class FavoriteBadgeIcon extends StatelessWidget {
  const FavoriteBadgeIcon({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteState, int>(
      selector: (state) => state is FavoriteLoaded ? state.items.length : 0,
      builder: (context, count) {
        return _BadgeIcon(icon: icon, count: count);
      },
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  const _BadgeIcon({required this.icon, required this.count});

  final Widget icon;
  final int count;

  @override
  Widget build(BuildContext context) {
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
        icon,
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
}
