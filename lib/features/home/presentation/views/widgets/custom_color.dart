
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

class CustomColor extends StatefulWidget {
  const CustomColor({super.key});

  @override
  State<CustomColor> createState() => _CustomColorState();
}

class _CustomColorState extends State<CustomColor> {
  final List<int> colors = const [green, darkGrey, red, grey];

  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, currentIndex, _) {
        return SizedBox(
          height: 40,
          width: MediaQuery.sizeOf(context).width * .8,
          child: ListView.builder(
            itemCount: colors.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final bool isSelected = currentIndex == index;

              return GestureDetector(
                onTap: () {
                  selectedIndex.value = index;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.2,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(colors[index]),

                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Color(
                                  colors[index],
                                ).withValues(alpha: 2),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Padding(
                      padding: isSelected
                          ? const EdgeInsets.all(16.0)
                          : const EdgeInsets.all(12.0),
                      child: const Text(" "),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
