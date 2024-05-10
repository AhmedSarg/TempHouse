import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

class MainDialog {
  String? dialogTitle;
  String? desc;

  static void showWaring(BuildContext context, dialogTitle,) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      descTextStyle: AppTextStyles.addImagesDescriptionTextStyle(context),
      animType: AnimType.rightSlide,
      title: dialogTitle??"",
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
  static void showError(BuildContext context, dialogTitle,) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      descTextStyle: AppTextStyles.addImagesDescriptionTextStyle(context),
      animType: AnimType.rightSlide,
      title: dialogTitle??"",
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
  static void showSuccess(BuildContext context, dialogTitle,void Function()? onevent) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      descTextStyle: AppTextStyles.addImagesDescriptionTextStyle(context),
      animType: AnimType.rightSlide,
      title: dialogTitle??"",
      btnCancelOnPress: () {},
      btnOkOnPress: onevent
    ).show();
  }
}
