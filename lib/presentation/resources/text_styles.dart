import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'langauge_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle baseStatesMessageTextStyle(BuildContext context,
          [Color? textColor]) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: textColor ?? ColorManager.white,
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

  static TextStyle registerTitleTextStyle(BuildContext context) => getBoldStyle(
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

  static TextStyle mainNavBarLabel(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle mainAppBarText(BuildContext context) => getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  // Home Screen

  static TextStyle searchTextStyle(BuildContext context) => getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f20,
      );

  static TextStyle searchHintTextStyle(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f20,
      );

  static TextStyle popularRowStartedTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: color,
        fontSize: FontSize.f24,
      );

  static TextStyle popularRowEndedTextStyle(
          BuildContext context, Color color) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f20,
      );

  static TextStyle homeItemPriceTextStyle(BuildContext context) =>
      getExtraBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f15,
      );

  static TextStyle homeItemRateTextStyle(BuildContext context) =>
      getExtraBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.orange,
        fontSize: FontSize.f15,
      );

  static TextStyle homeItemSecondTextStyle(BuildContext context) =>
      getExtraBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.lightblue,
        fontSize: FontSize.f15,
      );

  static TextStyle homeNameTextStyle(BuildContext context) => getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f22,
      );

  static TextStyle homeAddressTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.primary.withOpacity(.5),
        fontSize: FontSize.f16,
      );

  static TextStyle homeGeneralTextStyle(
          BuildContext context, Color color, double fontSize) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: color,
        fontSize: fontSize,
      );

  static TextStyle homeContentTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary.withOpacity(.5),
        fontSize: FontSize.f16,
      );

  ///home screen
  static TextStyle homeDetailsNameTextStyle(BuildContext context) =>
      getExtraBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f30,
      );

  static TextStyle homeDetailsDescriptionTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle homeDetailsDescriptionContactTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white.withOpacity(.95),
        fontSize: FontSize.f18,
      );

  static TextStyle noHomeToDisplayTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f30,
      );

  //# near by home
  static TextStyle nearHomeNameTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f17,
      );

  static TextStyle nearHomeAddressTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.primary.withOpacity(.5),
        fontSize: FontSize.f14,
      );

  static TextStyle smallTitleTextStyle(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey,
        fontSize: FontSize.f20,
      );

  // share post

  static TextStyle sharePostTextStyle(BuildContext context) => getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f16,
      );

  static TextStyle addImagesDescriptionTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f10,
      );

  static TextStyle sharePostBtnTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f16,
      );

// search screen

  static TextStyle searchScreenTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle searchScreenClearTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.tertiary,
        fontSize: FontSize.f15,
      );

  static TextStyle unselectedSearchTabTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f16,
      );

  static TextStyle selectedSearchTabTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f18,
      );

  static TextStyle modalBottomSheetButtonTextStyle(
          BuildContext context, Color color) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f18,
      );

  static TextStyle modalBottomSheetPriceTextStyle(
    BuildContext context,
  ) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f18,
      );

  static TextStyle modalBottomSheetPriceTitleTextStyle(
    BuildContext context,
  ) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f24,
      );

  ///feedback dialog

  static TextStyle feedBackHeaderTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f24,
      );

  static TextStyle feedBackSubHeadTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey.withOpacity(.8),
        fontSize: FontSize.f14,
      );

  static TextStyle feedBackBtnTextStyle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite,
        fontSize: FontSize.f19,
      );

//// google map
  static TextStyle googleMapHomeTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f24,
      );

  static TextStyle googleMapHomeTitleDescriptionTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle googleMapHomeDetailsTitleTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle googleMapHomeDetailsSubTitleTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey.withOpacity(.5),
        fontSize: FontSize.f16,
      );

  static TextStyle googleMapHomeDetailsSubTitleContactTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
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

  static TextStyle notificationsScreenItemBodyTextStyle(BuildContext context) =>
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

  static TextStyle chatsScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f24,
      );

  static TextStyle chatsScreenUserNameTitleTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f20,
      );

  static TextStyle chatsScreenLastMessageTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey,
        fontSize: FontSize.f18,
      );

  static TextStyle chatsScreenLastMessageDateTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey,
        fontSize: FontSize.f12,
      );

  static TextStyle chatsScreenSectionHeaderTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle chatsScreenNameTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f19,
      );

  static TextStyle chatsScreenMessageTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f17,
      );

  static TextStyle chatsScreenDateTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f12,
      );

  static TextStyle chatSendMessageTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );

  static TextStyle chatMessageTextStyle(BuildContext context) => getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black.withOpacity(.7),
        fontSize: FontSize.f18,
      );

  static TextStyle chatNoMessageTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite,
        fontSize: FontSize.f24,
      );

  static TextStyle chatTextFieldHintTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f20,
      );

  static TextStyle chatTimeTextStyle(BuildContext context) => getExtraBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey.withOpacity(.6),
        fontSize: FontSize.f12,
      );

  /// favourite screen

  static TextStyle favouriteScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  ///Options Menu

  static TextStyle optionsMenuOptionTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f15,
      );

  /// Chat Screen Text Styles

  static TextStyle chatScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightGrey,
        fontSize: FontSize.f24,
      );

  static TextStyle chatScreenMessageTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f16,
      );

  static TextStyle chatScreenUserNameTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle chatScreenInputTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f16,
      );

  ///profile screen

  static TextStyle profileInfoNameTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite,
        fontSize: FontSize.f20,
      );

  static TextStyle profileInfoEmailTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite.withOpacity(.6),
        fontSize: FontSize.f12,
      );

  static TextStyle profileSettingTextStyle(BuildContext context) =>
      getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.f24,
      );

  static TextStyle profileSettingInfoTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.f20,
      );

  static TextStyle profileSettingInfoDetailsTextStyle(BuildContext context) =>
      getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.f18,
      );

  static TextStyle profileSettingAppBarTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle profileSettingHeadQAppBarTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.f24,
      );

  static TextStyle profileSettingSubHeadQAppBarTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        color: ColorManager.grey,
        fontSize: FontSize.f18,
      );

  static TextStyle profileInfoTitle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  static TextStyle profileInfoSubTitle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle profileSettingBtnTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle personalInfoBtn(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.primary,
        fontSize: FontSize.f24,
      );

  static TextStyle aboutAppNameTextStyle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f30,
      );

  static TextStyle aboutAppVersionTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.grey.withOpacity(.8),
        fontSize: FontSize.f15,
      );

  static TextStyle aboutAppDescriptionTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f24,
      );

  static TextStyle aboutAppDescriptionDetailsTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black.withOpacity(.7),
        fontSize: FontSize.f18,
      );

  static TextStyle aboutAppDevTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f24,
      );

  static TextStyle aboutAppDevNameTextStyle(BuildContext context) =>
      getRegularStyle(
        color: ColorManager.black.withOpacity(.7),
        fontSize: FontSize.f18,
      );

  static TextStyle aboutAppContactTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f24,
      );

  static TextStyle aboutAppContactDetailsTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        color: ColorManager.black.withOpacity(.7),
        fontSize: FontSize.f18,
      );

  static TextStyle paymentTextStyle(BuildContext context) => getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle paymentAppBarTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  static TextStyle paymentBtnTextStyle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle paymentNoCardTextStyle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  ///Homes Map Screen

  static TextStyle homesMapScreenHomeDetailsTitleTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f28,
      );

  static TextStyle homesMapScreenHomeDetailsSubtitleTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f15,
      );

  static TextStyle homesMapScreenHomeDetailsButtonTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f17,
      );

  static TextStyle homesMapScreenHomeDetailsDetailTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f16,
      );

  static TextStyle homesMapScreenHomeDetailsDetailActionTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.anotherBlue,
        fontSize: FontSize.f16,
      );

  static TextStyle homesMapScreenHomeDetailsDetailHeadTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: const Color(0xff868782),
        fontSize: FontSize.f15,
      );

  static TextStyle homesMapScreenHomeDetailsDescriptionTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f12,
      );

  static TextStyle homesMapScreenHomeDetailsHeadTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f20,
      );
}
