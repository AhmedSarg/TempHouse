import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';

void showRegisterDialog(
  BuildContext context, {
  required void Function(String) onSelect,
  required String title,
  required List<String> items,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: AppTextStyles.registerDialogTitleTextStyle(context),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items
              .map(
                (e) => ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    onSelect(e);
                  },
                  splashColor: ColorManager.white,
                  title: Text(
                    e,
                    style: AppTextStyles.registerDialogItemTextStyle(context),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
