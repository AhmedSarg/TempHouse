import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';
import 'home_page_app_bar.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomePageAppBar(),
          const SizedBox(
            height: AppSize.s250,
          ),
          Container(
            height: AppSize.s500,
            decoration: const BoxDecoration(
              color: ColorManager.offwhite,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppSize.s50),
                topLeft: Radius.circular(AppSize.s50),
              ),
            ),
            padding: const EdgeInsets.all(AppPadding.p80),
            child: Lottie.asset(LottieAssets.underConstruction),
          )
        ],
      ),
    );
  }
}
