import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class ListViewCategoryText extends StatefulWidget {
  final void Function(String category) onCategorySelected;

  const ListViewCategoryText({super.key, required this.onCategorySelected});

  @override
  State<ListViewCategoryText> createState() => _ListViewCategoryTextState();
}

class _ListViewCategoryTextState extends State<ListViewCategoryText> {
  final List<String> categories = const [
    'All',
    'Newest',
    'Popular',
    'Men',
    'Women',
  ];

  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onCategorySelected(categories[selectedIndex.value]);
    });
  }

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
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final bool isSelected = currentIndex == index;
              return GestureDetector(
                onTap: () {
                  selectedIndex.value = index;
                  widget.onCategorySelected(categories[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(primaryColor)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4,
                      ),
                      child: Text(
                        categories[index],
                        style: isSelected
                            ? AppTextStyles.style14RegularWhite
                            : AppTextStyles.style16SemiBoldBlack,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: categories.length,
          ),
        );
      },
    );
  }
}