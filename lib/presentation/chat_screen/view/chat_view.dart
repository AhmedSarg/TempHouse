import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../common/widget/main_app_bar.dart';
import '../../resources/strings_manager.dart';
import 'widgets/chat_body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Row(
          children: [
            CircleAvatar(
              child: Image.asset(ImageAssets.personImage),
            ),
            const SizedBox(width: AppSize.s10),
            Text(
              'Glanda',
              style: AppTextStyles.chatScreenTitleTextStyle(context),
            ),
          ],
        ),
      ),
      body: const ChatScreenBody(),
    );
  }
}
