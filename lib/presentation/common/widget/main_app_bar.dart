import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/langauge_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

AppBar buildMainAppBar(BuildContext context,
    Widget? title,) {
  return AppBar(
    toolbarHeight: AppSize.s80,
    backgroundColor: ColorManager.transparent,
    centerTitle: false,
    title: title,
    scrolledUnderElevation: AppSize.s0,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(AppSize.s1_4),
      child: Container(
        color: ColorManager.lightGrey,
        height: AppSize.s1_4,
      ),
    ),
    actions: title is Text
        ? [
      IconButton(
        icon: const Icon(Icons.language_rounded),
        onPressed: () {
          AppLanguages.toggleLocal(context);
        },
      ),
    ]
        : null,
    elevation: AppSize.s0,
    shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
  );
}
