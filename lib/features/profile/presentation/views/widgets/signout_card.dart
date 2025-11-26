import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_button.dart';

import '../../../../auth/presentation/cubits/signout_cubit/signout_cubit.dart';

class SignoutCard extends StatelessWidget {
  const SignoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Container(
          decoration: const BoxDecoration(color: Color(scafoldColor)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: spacebetweenSections / 2),
              Divider(
                thickness: 3,
                color: Colors.grey.shade400,
                endIndent: 60,
                indent: 60,
              ),
              const SizedBox(height: spacebetweenSections / 2),
              const Text('Log Out', style: AppTextStyles.style16SemiBoldBlack),
              const SizedBox(height: spacebetweenSections / 3),
              Divider(
                thickness: 3,
                color: Colors.grey.shade400,
                endIndent: 10,
                indent: 10,
              ),
              const SizedBox(height: spacebetweenSections / 3),
              const Text(
                'Are You Sure You want to log out?',
                style: AppTextStyles.style14RegularGrey,
              ),
              const SizedBox(height: spacebetweenSections),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<SignoutCubit>(context).resetState();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade500),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'cancle',
                              style: AppTextStyles.style16SemiBoldBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: spacebetweenSections / 2),
                  Expanded(
                    child: CustomButton(
                      text: 'Yes, Logout',
                      onTap: () {
                        context.go(root);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: spacebetweenSections / 2),
            ],
          ),
        ),
      ),
    );
  }
}
