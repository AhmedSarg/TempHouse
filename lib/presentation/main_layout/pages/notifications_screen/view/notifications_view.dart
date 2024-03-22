import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/main_app_bar.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/text_styles.dart';
import 'widgets/notifications_body.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.notificationsScreenTitle.tr(),
          style: AppTextStyles.notificationsScreenTitleTextStyle(context),
        ),
      ),
      body: const NotificationsBody(),
    );
  }
}
