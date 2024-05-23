import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../common/widget/main_button.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';

class SelectionBody extends StatelessWidget {
  const SelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.selectionScreenTitle.tr(),
            style: AppTextStyles.selectionTitleTextStyle(context),
          ),
          Text(
            AppStrings.selectionScreenSubTitle.tr(),
            style: AppTextStyles.selectionSubTitleTextStyle(context),
          ),
          const SizedBox(
            height: AppSize.s80,
          ),
          MainButton(
            onTap: () {
              DataIntent.setUserRole(UserRole.owner);
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            text: AppStrings.selectionScreenOwner.tr(),
            textStyle: AppTextStyles.selectionOptionTextStyle(context),
          ),
          const SizedBox(height: AppSize.s30),
          MainButton(
            onTap: () {
              DataIntent.setUserRole(UserRole.tenant);
              Navigator.pushNamed(context, Routes.loginRoute);
            },
            text: AppStrings.selectionScreenTenant.tr(),
            textStyle: AppTextStyles.selectionOptionTextStyle(context),
          )
        ],
      ),
    );
  }
}
