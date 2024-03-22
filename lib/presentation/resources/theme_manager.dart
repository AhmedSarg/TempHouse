import 'color_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(

    useMaterial3: true,
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.darkGrey,
    // ripple effect color
    splashColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.primary,
    // app bar theme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.darkGrey,
      iconTheme: IconThemeData(color: ColorManager.white), //add this line here
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.white,
      surfaceTintColor: ColorManager.transparent
    ),

    dividerTheme: const DividerThemeData(
      color: ColorManager.black,
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s100),
      ),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightGrey,
    ),



    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorManager.white,
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s100),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: ColorManager.transparent,
        foregroundColor: ColorManager.primary,
        shape: const StadiumBorder(),
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: const InputDecorationTheme(
      // content padding
      contentPadding: EdgeInsets.all(AppPadding.p8),
      // hint style
    ),
  );
}
