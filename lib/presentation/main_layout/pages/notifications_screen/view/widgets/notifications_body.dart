import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/widget/options_menu.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppPadding.p20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.notificationsScreenUnread.tr(),
              style: AppTextStyles.notificationsScreenSectionHeaderTextStyle(
                  context),
            ),
            OptionMenu(
              items: [
                OptionMenuItem(
                  text: AppStrings.optionsMenuMarkAllRead.tr(),
                  icon: SvgPicture.asset(SVGAssets.markAsRead),
                  onPressed: () {},
                ),
                OptionMenuItem(
                  text: AppStrings.optionsMenuRemoveAll.tr(),
                  icon: SvgPicture.asset(SVGAssets.delete),
                  onPressed: () {},
                ),
              ], mainIcon: Icons.more_horiz_outlined,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const NotificationItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 30);
          },
        ),
        const SizedBox(height: AppSize.s50),
        Text(
          AppStrings.notificationsScreenAll.tr(),
          style:
              AppTextStyles.notificationsScreenSectionHeaderTextStyle(context),
        ),
        const SizedBox(height: AppSize.s20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          itemBuilder: (context, index) {
            return const NotificationItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 30);
          },
        ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: ColorManager.white,
          radius: AppSize.s25,
          child: Image.asset(ImageAssets.personImage),
        ),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Glanda ',
                  style: AppTextStyles.notificationsScreenPersonNameTextStyle(
                      context),
                  children: [
                    TextSpan(
                      text: 'just sent a photo, please check your message',
                      style: AppTextStyles.notificationsScreenItemBodyTextStyle(
                          context),
                    ),
                  ],
                ),
              ),
              Text(
                'Today at 08.00 AM',
                style: AppTextStyles.notificationsScreenDateTextStyle(context),
              ),
            ],
          ),
        )
      ],
    );
  }
}
