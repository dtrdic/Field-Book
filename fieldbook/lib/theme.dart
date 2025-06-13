import 'package:flutter/material.dart';

class AppColors {
  static const mainPrimary = Color(0xFF8BC34A);
  static const mainPrimaryDark = Color(0xFF689F38);
  static const mainColorAccent = Color(0xFF795548);
  static const mainPrimaryTransparent = Color(0x428BC34A);
  static const mainTraitPercentBackgroundCenterColor = Color(0xFFFFFFFF);
  static const mainTraitPercentBackgroundStartEndColor = Color(0xFFDDDDDD);
  static const mainTraitPercentStrokeColor = Color(0xFF689F38);
  static const mainTraitPercentStartColor = Color(0xFF8BC34A);
  static const mainColorBackground = Colors.white;
  static const mainColorTextLight = Colors.black;
  static const mainColorTextDark = Colors.black;
  static const mainColorTextButtonBackground = Color(0xFFD6D7D7);
  static const mainColorIconTint = Colors.black;
  static const mainColorIconFillTint = Colors.black;
  static const mainTraitBooleanFalseColor = Colors.red;
  static const mainTraitBooleanTrueColor = Color(0xFF689F38);
  static const mainBluetoothConnectedColor = Color(0xFF33B5E5);
  static const mainColorHintText = Colors.black;
  static const mainValueSavedColor = Color(0xFFD50000);
  static const mainValueAlteredColor = Color(0xFF0000D5);
  static const mainTraitCategoricalButtonPressColor = Color(0xFF33B5E5);
  static const mainButtonTextColor = Colors.black;
  static const mainButtonColorNormal = Color(0xFFD9D9D9);
  static const mainButtonColorPressed = Color(0xFF595959);
  static const mainSubheadingColor = Color(0xFF595959);
  static const mainColorTextSecondary = Color(0xFF595959);
  static const mainColorSeekbar = Color(0x42000000);
  static const mainColorSeekbarThumb = Color(0x90654321);
  static const lightGray = Color(0xFFE7E8E8);
  static const mainCardColorPressed = Color(0xFF9E9E9E);
  static const mainChipFirstColor = Color(0xFF47B65D);
  static const mainChipSecondColor = Color(0xFF00A771);
  static const mainChipThirdColor = Color(0xFF009683);
  static const mainInverseCropRegionColor = Color(0x80101010);
  static const datagridEmptyCellColor = Color(0xFFB6BABA);
  // Add more as needed
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.mainPrimary,
  primaryColorDark: AppColors.mainPrimaryDark,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.mainColorAccent,
    background: AppColors.mainColorBackground,
    primary: AppColors.mainPrimary,
    onPrimary: AppColors.mainColorTextLight,
    onSecondary: AppColors.mainColorTextDark,
  ),
  scaffoldBackgroundColor: AppColors.mainColorBackground,
  hintColor: AppColors.mainColorHintText,
  // errorColor: Colors.grey, // fb_error_message_color
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.mainColorTextLight),
    bodyMedium: TextStyle(color: AppColors.mainColorTextDark),
    labelLarge: TextStyle(color: AppColors.mainColorTextButtonBackground),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.mainColorIconTint,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.mainChipFirstColor,
    selectedColor: AppColors.mainChipSecondColor,
    secondarySelectedColor: AppColors.mainChipThirdColor,
    labelStyle: const TextStyle(color: Colors.black),
    secondaryLabelStyle: const TextStyle(color: Colors.black),
    brightness: Brightness.light,
    disabledColor: Colors.grey,
    padding: const EdgeInsets.all(4),
    shape: const StadiumBorder(),
  ),
  // Add more mappings as needed for your app
);

