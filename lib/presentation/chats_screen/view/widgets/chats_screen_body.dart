import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/options_menu.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import 'chats_item.dart';

class ChatsScreenBody extends StatelessWidget {
  const ChatsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.chatsScreenUnread.tr(),
                style: AppTextStyles.chatsScreenSectionHeaderTextStyle(
                    context),
              ),
              OptionMenu(),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const ChatsItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: AppSize.s10);
          },
        ),
        const SizedBox(height: AppSize.s30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Text(
            AppStrings.chatsScreenAll.tr(),
            style:
            AppTextStyles.chatsScreenSectionHeaderTextStyle(context),
          ),
        ),
        const SizedBox(height: AppSize.s20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          itemBuilder: (context, index) {
            return const ChatsItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: AppSize.s10);
          },
        ),
      ],
    );
  }
}
