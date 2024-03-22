import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import 'onboarding_image.dart';
import 'onboarding_items.dart';
import 'onboarding_text.dart';

class OnBoardingBody extends StatelessWidget {
  OnBoardingBody({super.key});

  final List<OnBoardingItem> onboardingItems = [
    OnBoardingItem(
      image: ImageAssets.onboardingImage1,
      title: AppStrings.onBoardingScreenTitle1.tr(),
      btnName: AppStrings.onBoardingScreenNextButton.tr(),
    ),
    OnBoardingItem(
      image: ImageAssets.onboardingImage2,
      title: AppStrings.onBoardingScreenTitle2.tr(),
      btnName: AppStrings.onBoardingScreenGetStartedButton.tr(),
    ),
  ];

  final PageController imageController = PageController();
  final PageController boxController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: onboardingItems.length,
          controller: imageController,
          itemBuilder: (context, index) {
            return OnboardingImage(
              onboardImage: onboardingItems[index].image,
            );
          },
          onPageChanged: (index) {
            boxController.animateToPage(
              index,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
        ),
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height * .35,
            width: AppSize.infinity,
            decoration: const BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s28),
                topRight: Radius.circular(AppSize.s28),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: PageView.builder(
                itemCount: onboardingItems.length,
                controller: boxController,
                itemBuilder: (context, index) {
                  return OnboardingText(
                    btnName: onboardingItems[index].btnName,
                    title: onboardingItems[index].title,
                    onPressed: () {
                      if (index == 0) {
                        boxController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.selectionRoute,
                          ModalRoute.withName('/'),
                        );
                      }
                    },
                  );
                },
                onPageChanged: (index) {
                  imageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
