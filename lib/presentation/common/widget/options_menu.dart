import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class OptionMenuItem {
  final IconData icon;
  final String text;
  final Function onPressed;

  OptionMenuItem({
    required this.icon,
    required this.text,
    required this.onPressed,
  });
}

class OptionMenu extends StatelessWidget {
  OptionMenu({super.key});

  final List<OptionMenuItem> menu = [
    OptionMenuItem(
      text: AppStrings.optionsMenuMarkAllRead.tr(),
      icon: Icons.check,
      onPressed: () {},
    ),
    OptionMenuItem(
      text: AppStrings.optionsMenuRemoveAll.tr(),
      icon: Icons.delete,
      onPressed: () {},
    ),
  ];

  List<PopupMenuEntry> buildOptions(
      BuildContext context,
      List<OptionMenuItem> items,
      ) {
    List<PopupMenuEntry> list = [];
    for (OptionMenuItem item in items) {
      list.add(
        PopupMenuItem(
          onTap: () {
            item.onPressed();
          },
          child: Row(
            children: [
              Icon(
                item.icon,
                color: ColorManager.primary,
              ),
              const SizedBox(width: AppSize.s10),
              Text(
                item.text,
                style:
                AppTextStyles.optionsMenuOptionTextStyle(context),
              ),
            ],
          ),
        ),
      );
      list.add(
        const PopupMenuDivider(
          height: AppSize.s1,
        ),
      );
    }
    list.removeLast();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_horiz_outlined),
      color: ColorManager.offwhite,
      iconColor: ColorManager.white,
      offset: const Offset(-AppSize.s50, AppSize.s0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      itemBuilder: (context) => buildOptions(context, menu),
    );
  }
}