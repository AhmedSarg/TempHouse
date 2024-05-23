import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/langauge_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class LanguageSelectionModal {
  void show(BuildContext context, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildLanguageSelectionModal(context, onSelect);
      },
    );
  }

  Widget _buildLanguageSelectionModal(
      BuildContext context, Function(String) onSelect) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p22),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: AppSize.s4,
              width: AppPadding.p40,
              decoration: BoxDecoration(
                color: ColorManager.grey,
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
            ),
          ),
          Text(
            AppStrings.profileLanguage.tr(),
            style: AppTextStyles.profileSettingTextStyle(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _saveLanguageSelection(
                        AppStrings.profileLanguageEnglish.tr());

                    AppLanguages.setLanguageEnglish(context);

                    onSelect(AppStrings.profileLanguageEnglish.tr());
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.profileLanguageEnglish.tr(),
                    style: AppTextStyles.profileSettingInfoTextStyle(context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _saveLanguageSelection(
                      AppStrings.profileLanguageArabic.tr(),
                    );
                    AppLanguages.setLanguageArabic(context);

                    onSelect(AppStrings.profileLanguageArabic.tr());
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.profileLanguageArabic.tr(),
                    style: AppTextStyles.profileSettingInfoTextStyle(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveLanguageSelection(String selectedLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', selectedLanguage);
  }
}
