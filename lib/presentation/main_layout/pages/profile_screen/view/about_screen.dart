import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_image.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offwhite,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: MainImage(imageUrl: ImageAssets.appImage),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutAppName.tr(),
              style: AppTextStyles.aboutAppNameTextStyle(context),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutAppVersion.tr(),
              style: AppTextStyles.aboutAppVersionTextStyle(context),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.aboutAppDescription.tr(),
              style: AppTextStyles.aboutAppDescriptionTextStyle(context),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutAppDescriptionDetails.tr(),
              style: AppTextStyles.aboutAppDescriptionDetailsTextStyle(context),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.aboutDev.tr(),
              style: AppTextStyles.aboutAppDevTextStyle(context),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutDevNames
                  .tr(), // Replace with your name or company name
              style: AppTextStyles.aboutAppDevNameTextStyle(context),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.aboutContact.tr(),
              style: AppTextStyles.aboutAppContactTextStyle(context),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              '${AppStrings.aboutContactEmail.tr()}\n ${AppStrings.aboutContactWebSite.tr()}', // Replace with your contact information
              style: AppTextStyles.aboutAppContactDetailsTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
