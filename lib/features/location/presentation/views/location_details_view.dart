import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_button.dart';

import '../cubits/location/location_cubit.dart';
import 'widgets/custom_home_location.dart';
import 'widgets/edit_button_location.dart';

class LocationDetailsView extends StatefulWidget {
  const LocationDetailsView({super.key});

  @override
  State<LocationDetailsView> createState() => _LocationDetailsViewState();
}

class _LocationDetailsViewState extends State<LocationDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().getLocations();
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
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Add Address',
                  style: AppTextStyles.style20BoldBlack3,
                ),
              ),
              const SizedBox(height: spacebetweenSections),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 15.0,
                        color: Color(primaryColor),
                      ),
                    );
                  }

                  if (state is LocationFailure) {
                    return Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  if (state is LocationSuccess) {
                    if (state.locations.isEmpty) {
                      return const CustomHomeLocation(
                        address: 'No address added yet',
                      );
                    }
                    final loc = state.locations.first;
                    final address =
                        '${loc.governorate}, ${loc.city}, ${loc.phoneNumber}';
                    return CustomHomeLocation(address: address);
                  }

                  return const CustomHomeLocation(address: '');
                },
              ),

              const SizedBox(height: spacebetweenSections),

              CustomButton(
                text: 'Apply',
                onTap: () {
                  context.go(thanksView);
                },
              ),

              const SizedBox(height: spacebetweenSections),

              EditButtonLocation(
                onTap: () {
                  context.go(addLocationView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
