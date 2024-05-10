import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/widgets/profile_body.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/text_styles.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.profileAppBar.tr(),
          style: AppTextStyles.notificationsScreenTitleTextStyle(context),
        ),
      ),
      body: ProfileBody(),
    );
  }
}
