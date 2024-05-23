import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/common/widget/main_text_field.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

class NeedHelpScreen extends StatelessWidget {
  const NeedHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offwhite,
      appBar: AppBar(
        title: Text(
          AppStrings.needHelpScreenNavBar.tr(),
          style: AppTextStyles.profileSettingAppBarTextStyle(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppStrings.needHelpScreenTitle.tr(),
              style: AppTextStyles.profileSettingHeadQAppBarTextStyle(context),
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.needHelpScreenSubtitle.tr(),
              style:
                  AppTextStyles.profileSettingSubHeadQAppBarTextStyle(context),
            ),
            const SizedBox(height: 10),
            MainTextField(
                hint: AppStrings.needHelpScreenHint.tr(),
                maxLines: 3,
                backgroundColor: ColorManager.primary.withOpacity(.8)),
            const SizedBox(height: 20),
            Center(
              child: MainButton(
                backgroundColor: ColorManager.primary,
                text: AppStrings.needHelpScreenButton.tr(),
                textStyle: AppTextStyles.profileSettingBtnTextStyle(context),
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
