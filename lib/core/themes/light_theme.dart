import 'package:flutter/material.dart';
import 'package:pms/core/themes/app_colors.dart';
import 'package:pms/core/themes/app_text.dart';


ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: AppTextStyles.fontFamily,

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.amber50,
    onPrimaryContainer: AppColors.amber800,
    secondary: AppColors.teal400,
    onSecondary: Colors.white,
    secondaryContainer: const Color(0xFFE1F5EE),
    onSecondaryContainer: AppColors.teal800,
    surface: AppColors.lightSurface,
    onSurface: const Color(0xFF2D1A00),
    surfaceContainerHighest: AppColors.lightBackground,
    error: const Color(0xFFE24B4A),
    onError: Colors.white,
    outline: const Color(0xFFF5C97A),
    outlineVariant: const Color(0xFFFAEEDA),
  ),

  scaffoldBackgroundColor: AppColors.lightBackground,

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.primary,
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontFamily: AppTextStyles.fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightSurface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: Color(0xFFC4865A),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: TextStyle(
      fontFamily: AppTextStyles.fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: AppTextStyles.fontFamily,
      fontSize: 11,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.amber50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0x50F5C97A)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0x50F5C97A)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    hintStyle: const TextStyle(color: Color(0xFFC4865A)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: const TextStyle(
        fontFamily: AppTextStyles.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    ),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: AppColors.amber50,
    labelStyle: const TextStyle(
      color: AppColors.amber800,
      fontFamily: AppTextStyles.fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    side: const BorderSide(color: Color(0x50FAC775)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0x20F5C97A),
    thickness: 0.8,
  ),
);

