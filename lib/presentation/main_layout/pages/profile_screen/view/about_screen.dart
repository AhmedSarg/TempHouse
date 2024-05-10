import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offwhite,
      appBar: AppBar(
        // title: Text(AppStrings.aboutAppItem,style: AppTextStyles.profileSettingAppBarTextStyle(),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.home),
              ),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutAppName.tr(),
              style: AppTextStyles.aboutAppNameTextStyle(),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutAppVersion.tr(), // Replace with your app version
              style: AppTextStyles.aboutAppVersionTextStyle(),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.aboutAppDescription.tr(),
              style: AppTextStyles.aboutAppDescriptionTextStyle(),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutAppDescriptionDetails.tr(),
              style: AppTextStyles.aboutAppDescriptionDetailsTextStyle(),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.aboutDev.tr(),
              style: AppTextStyles.aboutAppDevTextStyle(),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.aboutDevNames.tr(), // Replace with your name or company name
              style: AppTextStyles.aboutAppDevNameTextStyle(),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.aboutContact.tr(),
              style: AppTextStyles.aboutAppContantTextStyle(),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              '${AppStrings.aboutContactEmail.tr()}\n ${AppStrings.aboutContactWebSite.tr()}', // Replace with your contact information
              style: AppTextStyles.aboutAppContantDetailsTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
