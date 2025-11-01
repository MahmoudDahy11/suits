import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

class AuthToggleSwitch extends StatelessWidget {
  final ValueNotifier<int> controller;
  final ValueChanged<int>? onToggle;

  const AuthToggleSwitch({super.key, required this.controller, this.onToggle});

  @override
  Widget build(BuildContext context) {
    const Color activeColor = Color(primaryColor);
    final Color inactiveColor = Colors.grey[600]!;
    const Color backgroundColor = Color(fillColorTextField);
    const Color activeBgColor = Colors.white;

    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: controller,
                builder: (context, selectedIndex, _) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    left: selectedIndex * itemWidth,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: itemWidth,
                      decoration: BoxDecoration(
                        color: activeBgColor,
                        borderRadius: BorderRadius.circular(26.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              Row(
                children: [
                  _ToggleText(
                    index: 0,
                    text: "Email",
                    controller: controller,
                    onToggle: onToggle,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                  ),
                  _ToggleText(
                    index: 1,
                    text: "Phone",
                    controller: controller,
                    onToggle: onToggle,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ToggleText extends StatelessWidget {
  final int index;
  final String text;
  final ValueNotifier<int> controller;
  final ValueChanged<int>? onToggle;
  final Color activeColor;
  final Color inactiveColor;

  const _ToggleText({
    required this.index,
    required this.text,
    required this.controller,
    required this.onToggle,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<int>(
        valueListenable: controller,
        builder: (context, selectedIndex, _) {
          final bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              controller.value = index;
              onToggle?.call(index);
            },
            child: Center(
              child: AnimatedScale(
                scale: isSelected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    color: isSelected ? activeColor : inactiveColor,
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  child: Text(text),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
