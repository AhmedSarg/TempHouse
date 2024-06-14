import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_house/data/data_source/cache_data_source.dart';
import 'package:temp_house/data/network/error_handler.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/widgets/profile_image.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/values_manager.dart';
import 'bottom_sheet_item.dart';
import 'country_selection_modal.dart';
import 'language_selection_modal.dart';
import 'measurement_selection_modal.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String selectedLanguage = 'English';
  String selectedMeasurement = 'Metric (m^2 , Km)';
  String selectedCountry = 'Egypt';
  CacheDataSource? _cacheDataSource;

  @override
  void initState() {
    super.initState();
    _retrieveLanguageSelection();
  }

  Future<void> _retrieveLanguageSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
    });
  }

  Future<void> _saveLanguageSelection(String selectedLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', selectedLanguage);
  }

  void _showLanguageSelectionModal(BuildContext context) {
    LanguageSelectionModal().show(context, (selectedLanguage) {
      _saveLanguageSelection(selectedLanguage);
      setState(() {
        this.selectedLanguage = selectedLanguage;
      });
    });
  }

  void _showMeasurementSelectionModal(BuildContext context) {
    MeasurementSelectionModal().show(context, (selectedMeasurement) {
      setState(() {
        this.selectedMeasurement = selectedMeasurement;
      });
    });
  }

  void _showCountrySelectionModal(BuildContext context) {
    CountrySelectionModal().show(context, (selectedCountry) {
      setState(() {
        this.selectedCountry = selectedCountry;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.personalInfoRoute);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p20),
                child: ProfileImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
              child: Text(
                AppStrings.profileSetting.tr(),
                style: AppTextStyles.profileSettingTextStyle(context),
              ),
            ),
            ModelSheetItem(
              subTitle: selectedLanguage,
              onTap: () => _showLanguageSelectionModal(context),
              title: AppStrings.profileLanguage.tr(),
            ),
            ModelSheetItem(
              subTitle: selectedCountry,
              onTap: () => _showCountrySelectionModal(context),
              title: AppStrings.profileCountry.tr(),
            ),
            ModelSheetItem(
              subTitle: selectedMeasurement,
              onTap: () => _showMeasurementSelectionModal(context),
              title: AppStrings.profileMeasurement.tr(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.paymentScreenRoute);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p30, right: AppPadding.p40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.paymentScreenTitle.tr(),
                        style:
                            AppTextStyles.profileSettingInfoTextStyle(context)),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const Divider(color: ColorManager.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
              child: Text(AppStrings.profilePropertyFinder.tr(),
                  style: AppTextStyles.profileSettingTextStyle(context)),
            ),
            AppSettingItem(
              text: AppStrings.profileAbout.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.aboutScreenRoute);
              },
            ),
            AppSettingItem(
              text: AppStrings.needHelpScreenName.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.needHelpScreenRoute);
              },
            ),
            AppSettingItem(
              text: AppStrings.logOut.tr(),
              onTap: () {
                _cacheDataSource!.logout().then((value) {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
