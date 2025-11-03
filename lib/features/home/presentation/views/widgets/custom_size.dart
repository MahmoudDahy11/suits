
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class CustomSize extends StatefulWidget {
  const CustomSize({super.key});

  @override
  State<CustomSize> createState() => _CustomSizeState();
}

class _CustomSizeState extends State<CustomSize> {
  final List<String> sizes = const ["S", "M", "L", "XL"];

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
          height: 45,
          child: ListView.builder(
            itemCount: sizes.length,
            scrollDirection: Axis.horizontal,

            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            itemBuilder: (context, index) {
              final bool isSelected = currentIndex == index;

              return GestureDetector(
                onTap: () {
                  selectedIndex.value = index;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected
                          ? const Color(primaryColor)
                          : Colors.grey.shade300,
                    ),
                    child: Text(
                      sizes[index],
                      style: AppTextStyles.style20BoldBlack.copyWith(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
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
