import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/main_layout/pages/favourite_screen/view/widgets/favourite_body.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.favouraiteScreenTitle.tr(),
          style: AppTextStyles.homeGeneralTextStyle(
              context, ColorManager.white, FontSize.f24),
        ),
        ColorManager.primary,
      ),
      backgroundColor: ColorManager.offwhite,
      body: const FavouriteBody(),
    );
  }
}
