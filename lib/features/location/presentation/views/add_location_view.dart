import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/constant/egypt_locations.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';
import 'package:suits/features/location/data/models/location_model.dart';
import 'package:suits/features/location/presentation/cubits/location/location_cubit.dart';
import 'package:suits/features/location/presentation/views/widgets/phone_text_field.dart';

class AddLocationView extends StatefulWidget {
  const AddLocationView({super.key});

  @override
  State<AddLocationView> createState() => _AddLocationViewState();
}

class _AddLocationViewState extends State<AddLocationView> {
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    governorateController.dispose();
    cityController.dispose();
    selectedGovernorate.dispose();
    super.dispose();
  }

  final String lang = "ar";
  String? city, governorate, phone;
  final ValueNotifier<String> selectedGovernorate = ValueNotifier("");

  List<String> getAllGovernorates() {
    return egyptLocations
        .expand((g) => [g["ar"] as String, g["en"] as String])
        .toList();
  }

  Map<String, dynamic>? findGovernorate(String input) {
    final lower = input.toLowerCase();

    try {
      return egyptLocations.firstWhere(
        (g) =>
            (g["ar"] as String).toLowerCase() == lower ||
            (g["en"] as String).toLowerCase() == lower,
      );
    } catch (_) {
      return null;
    }
  }

  List<String> getCitiesForGovernorate(String governorate) {
    final gov = findGovernorate(governorate);
    if (gov == null) return [];

    return (gov["cities"] as List)
        .expand((c) => [c["ar"] as String, c["en"] as String])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final allGovernorates = getAllGovernorates();

    return BlocConsumer<LocationCubit, LocationState>(
      listener: (BuildContext context, LocationState state) {
        if (state is LocationFailure) {
          showSnakBar(context, state.errorMessage, isError: true);
        } else if (state is LocationSuccess) {
          context.go(locationDetailsView);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: const Color(scafoldColor),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Address',
                          style: AppTextStyles.style20BoldBlack3,
                        ),
                      ),
                      const SizedBox(height: spacebetweenSections),
                      Autocomplete<String>(
                        optionsBuilder: (value) {
                          if (value.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          final q = value.text.toLowerCase();
                          return allGovernorates.where(
                            (g) => g.toLowerCase().contains(q),
                          );
                        },
                        fieldViewBuilder: (context, controller, focusNode, _) {
                          governorateController.text = controller.text;
                          return CustomTextField(
                            controller: controller,
                            focusNode: focusNode,
                            hintText: lang == "ar" ? "المحافظة" : "Governorate",
                            prefixIcon: const Icon(
                              Icons.location_city,
                              color: Color(primaryColor),
                            ),
                            onSaved: (value) {
                              governorate = value;
                            },
                          );
                        },
                        onSelected: (selectedGov) {
                          governorateController.text = selectedGov;
                          selectedGovernorate.value = selectedGov;
                          cityController.clear();
                        },
                      ),
                      const SizedBox(height: spacebetweenSections / 2),
                      ValueListenableBuilder<String>(
                        valueListenable: selectedGovernorate,
                        builder: (context, govValue, _) {
                          final cities = getCitiesForGovernorate(govValue);
                          return Autocomplete<String>(
                            optionsBuilder: (value) {
                              if (value.text.isEmpty) {
                                return const Iterable<String>.empty();
                              }
                              final query = value.text.toLowerCase();
                              return cities.where(
                                (c) => c.toLowerCase().contains(query),
                              );
                            },
                            fieldViewBuilder:
                                (context, controller, focusNode, _) {
                                  cityController.text = controller.text;
                                  return CustomTextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    hintText: lang == "ar" ? "المدينة" : "City",
                                    prefixIcon: const Icon(
                                      Icons.home,
                                      color: Color(primaryColor),
                                    ),
                                    onSaved: (value) {
                                      city = value;
                                    },
                                  );
                                },
                            onSelected: (city) {
                              cityController.text = city;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: spacebetweenSections / 2),
                      PhoneTextField(
                        hintText: "Phone Number",
                        onSaved: (value) {
                          phone = value;
                        },
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Color(primaryColor),
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        check: state is LocationLoading,
                        text: 'Next',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            final userId =
                                FirebaseAuth.instance.currentUser!.uid;
                            final newLocation = LocationModel(
                              id: userId,
                              governorate: governorate!,
                              city: city!,
                              phoneNumber: phone!,
                            );
                            final cubit = context.read<LocationCubit>();
                            await cubit.getLocations();
                            final currentState = cubit.state;
                            if (currentState is LocationSuccess &&
                                currentState.locations.isNotEmpty) {
                              final old = currentState.locations.first;
                              final updated = LocationModel(
                                id: old.id,
                                governorate: governorate!,
                                city: city!,
                                phoneNumber: phone!,
                              );
                              cubit.updateLocation(updated);
                            } else {
                              cubit.addLocation(newLocation);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: spacebetweenSections / 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
