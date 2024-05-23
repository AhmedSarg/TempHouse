import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/popular_home_widget.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/popular_row.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';
import 'home_page_app_bar.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: AppSize.s16,
          ),
          const HomePageAppBar(),
          const SizedBox(
            height: AppSize.s20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.searchScreenRoute);
            },
            child: Container(
              height: AppSize.s50,
              width: MediaQuery.of(context).size.width * .80,
              decoration: BoxDecoration(
                  color: ColorManager.offwhite.withOpacity(.12),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const SizedBox(
                    width: AppSize.s10,
                  ),
                  const Icon(
                    Icons.search,
                    color: ColorManager.white,
                  ),
                  const SizedBox(
                    width: AppSize.s5,
                  ),
                  Text(
                    AppStrings.searchTextHint.tr(),
                    style: AppTextStyles.searchHintTextStyle(context),
                  ),
                  const Spacer(),
                  const Icon(Icons.tune, color: ColorManager.white),
                  const SizedBox(
                    width: AppSize.s10,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          PopularRow(
            startedText: AppStrings.popularStartedTextRow.tr(),
            endedText: AppStrings.popularEndedTextRow.tr(),
            rowStartedcolor: ColorManager.white,
            rowEndedcolor: ColorManager.tertiary.withOpacity(.4),
            routeName: Routes.allPopularHomesRoute,
          ),
          const SizedBox(height: AppSize.s20),
          const PopularHomeWidget()
        ],
      ),
    );
  }
}
