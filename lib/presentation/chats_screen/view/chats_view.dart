import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../common/widget/main_app_bar.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import 'widgets/chats_screen_body.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Text(
          AppStrings.chatsScreenTitle.tr(),
          style: AppTextStyles.chatsScreenTitleTextStyle(context),
        ),
      ),
      body: const ChatsScreenBody(),
    );
  }
}
