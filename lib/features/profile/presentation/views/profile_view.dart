import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/features/auth/presentation/cubits/signout_cubit/signout_cubit.dart';
import 'package:suits/features/profile/presentation/views/widgets/custom_image_profile.dart';
import 'package:suits/features/profile/presentation/views/widgets/custom_list_tile_profile.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../auth/presentation/views/widgets/card_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);
  final ValueNotifier<String?> _networkImageUrl = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  @override
  void dispose() {
    _isLoading.dispose();
    _networkImageUrl.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        _isLoading.value = false;
        return;
      }
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists &&
          doc.data() != null &&
          doc.data()!.containsKey('profileImageUrl')) {
        _networkImageUrl.value = doc.data()!['profileImageUrl'];
      }
    } catch (e) {
      log("Error loading profile data: $e");
    }
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignoutCubit, SignoutState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          excuteDialog(context);
        } else if (state is SignOutFailure) {
          showSnakBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: const Color(scafoldColor),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isLoading,
                  builder: (context, isLoading, _) {
                    return Skeletonizer(
                      enabled: isLoading,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Skeleton.keep(
                                child: Text(
                                  "Profile",
                                  style: AppTextStyles.style20BoldBlack,
                                ),
                              ),
                            ),
                            const SizedBox(height: spacebetweenSections),
                            ValueListenableBuilder<String?>(
                              valueListenable: _networkImageUrl,
                              builder: (context, imageUrl, _) {
                                return CustomImageProfile(
                                  networkImageUrl: imageUrl,
                                );
                              },
                            ),
                            const SizedBox(height: spacebetweenSections / 2),
                            const Text(
                              "Mahmoud Dahy",
                              style: AppTextStyles.style20BoldBlack,
                            ),
                            const SizedBox(height: spacebetweenSections),
                            const CustomListTileProfile(
                              title: 'Your Profile',
                              icon: Icons.person,
                            ),
                            const SizedBox(height: spacebetweenSections),
                            const CustomListTileProfile(
                              title: 'My Order',
                              icon: Icons.menu,
                            ),
                            const SizedBox(height: spacebetweenSections),
                            const CustomListTileProfile(
                              title: 'Payment Methods',
                              icon: Icons.payments_rounded,
                            ),
                            const SizedBox(height: spacebetweenSections),
                            const CustomListTileProfile(
                              title: 'Wishlist',
                              icon: Icons.favorite_border,
                            ),
                            const SizedBox(height: spacebetweenSections),
                            const CustomListTileProfile(
                              title: 'Setting',
                              icon: Icons.settings,
                            ),
                            const SizedBox(height: spacebetweenSections),
                            CustomListTileProfile(
                              onTap: () {
                                BlocProvider.of<SignoutCubit>(
                                  context,
                                ).signOut();
                              },
                              title: 'Log Out',
                              icon: Icons.login_sharp,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void excuteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.5,
            child: Material(
              type: MaterialType.transparency,
              child: CardView(
                title: "Logout",
                description: "Are You Sure You want to log out?",
                titleButton: "Yes, Logout",
                onPressed: () {
                  Navigator.pop(dialogContext);
                  context.go(loginView);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
