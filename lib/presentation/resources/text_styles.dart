import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'langauge_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle baseStatesMessageTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f22,
      );

  static TextStyle baseStatesElevatedBtnTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Splash Text Styles

  static TextStyle splashScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f32,
      );

  static TextStyle splashScreenSubTitleTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f18,
      );

  ///onBoarding Text Styles

  static TextStyle onBoardingTextStyle(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f24,
      );

  static TextStyle onBoardingButtonTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f30,
      );

  ///Selection Text Styles

  static TextStyle selectionTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f35,
      );

  static TextStyle selectionSubTitleTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f24,
      );

  static TextStyle selectionOptionTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f30,
      );

  /// Auth Text Style

  static TextStyle authLabelTextStyle(BuildContext context) => getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f24,
      );

  static TextStyle authHintTextStyle(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f20,
      );

  static TextStyle authButtonTextStyle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f30,
      );

  static TextStyle authSocialTextStyle(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f20,
      );

  static TextStyle authActionsTextStyle(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.tertiary.withOpacity(.4),
        fontSize: FontSize.f20,
      );

  static TextStyle authErrorTextStyle(BuildContext context) => getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.error,
        fontSize: FontSize.f14,
      );

  ///Login Text Styles

  static TextStyle loginTitleTextStyle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f24,
      );

  ///Login Text Styles

  static TextStyle registerTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f24,
      );

  static TextStyle registerDialogTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f30,
      );

  static TextStyle registerDialogItemTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f20,
      );

  ///Forgot Password Text Styles

  static TextStyle forgotPasswordTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f24,
      );

  static TextStyle forgotPasswordEmailValueTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary.withOpacity(.3),
        fontSize: FontSize.f20,
      );

  static TextStyle forgotPasswordSendCodeTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f30,
      );

  ///Reset Password Text Styles

  static TextStyle resetPasswordTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f24,
      );

  static TextStyle resetPasswordEmailValueTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary.withOpacity(.3),
        fontSize: FontSize.f20,
      );

  static TextStyle resetPasswordPasswordLabelTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f24,
      );

  static TextStyle resetPasswordPasswordHintTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary.withOpacity(.3),
        fontSize: FontSize.f20,
      );

  static TextStyle resetPasswordChangeTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f30,
      );

  ///Main Layout

  static TextStyle mainNavBarLabel(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle mainAppBarText(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  ///Notifications Screen Text Styles

  static TextStyle notificationsScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  static TextStyle notificationsScreenSectionHeaderTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle notificationsScreenPersonNameTextStyle(
          BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle notificationsScreenItemBodyTextStyle(
          BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );

  static TextStyle notificationsScreenDateTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f14,
      );

  ///Chats Screen Text Styles

  static TextStyle chatsScreenTitleTextStyle(BuildContext context) => getBoldStyle(
    fontFamily: AppLanguages.getPrimaryFont(context),
    color: ColorManager.lightGrey,
    fontSize: FontSize.f24,
  );

  static TextStyle chatsScreenSectionHeaderTextStyle(
      BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle chatsScreenNameTextStyle(BuildContext context) => getBoldStyle(
    fontFamily: AppLanguages.getPrimaryFont(context),
    color: ColorManager.secondary,
    fontSize: FontSize.f19,
  );

  static TextStyle chatsScreenMessageTextStyle(BuildContext context) => getLightStyle(
    fontFamily: AppLanguages.getPrimaryFont(context),
    color: ColorManager.offwhite.withOpacity(.6),
    fontSize: FontSize.f17,
  );

  static TextStyle chatsScreenDateTextStyle(BuildContext context) => getLightStyle(
    fontFamily: AppLanguages.getPrimaryFont(context),
    color: ColorManager.offwhite.withOpacity(.6),
    fontSize: FontSize.f12,
  );

  ///Options Menu

  static TextStyle optionsMenuOptionTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f15,
      );

  /// Chat Screen Text Styles

  static TextStyle chatScreenTitleTextStyle(BuildContext context) => getBoldStyle(
    fontFamily: AppLanguages.getPrimaryFont(context),
    color: ColorManager.lightGrey,
    fontSize: FontSize.f24,
  );

  static TextStyle chatScreenMessageTextStyle(BuildContext context, Color color) => getRegularStyle(
    fontFamily: AppLanguages.getPrimaryFont(context),
    color: color,
    fontSize: FontSize.f16,
  );

  static TextStyle chatScreenInputTextStyle(BuildContext context) => getRegularStyle(
    fontFamily: AppLanguages.getPrimaryFont(context),
    color: ColorManager.secondary,
    fontSize: FontSize.f16,
  );

}
