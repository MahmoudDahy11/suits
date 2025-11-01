import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/assets.dart';
import 'package:suits/features/onboarding/views/get_started.dart';

import 'views/screen_one.dart';
import 'views/screen_three.dart';
import 'views/screen_two.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final PageController controller = PageController();
  List<Widget> screens = [
    const ScreenOne(),
    const ScreenTwo(),
    const ScreenThree(),
    const GetStarted(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: screens,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Positioned(
            top: 50,
            right: 20,
            child: selectedIndex < screens.length - 1
                ? GestureDetector(
                    onTap: () {
                      if (controller.page! < screens.length - 1) {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {}
                    },
                    child: Image.asset(Assets.imagesGroup2, width: 100),
                  )
                : const SizedBox(),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: selectedIndex < screens.length - 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        selectedIndex >= 1
                            ? Container(
                                padding: const EdgeInsets.all(
                                  defaultCirclerpadding - 8,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: const Color(secodaryColor),
                                    width: 3,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.page! > 0) {
                                      controller.previousPage(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {}
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 30,
                                    color: Color(primaryColor),
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        Transform.translate(
                          offset: const Offset(0, -20),
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: screens.length - 1,
                            effect: const WormEffect(
                              activeDotColor: Color(primaryColor),
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(
                            defaultCirclerpadding - 8,
                          ),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(primaryColor),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (controller.page! < screens.length - 1) {
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              } else {}
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
