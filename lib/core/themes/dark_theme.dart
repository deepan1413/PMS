import 'package:flutter/material.dart';
import 'package:pms/core/themes/app_colors.dart';
import 'package:pms/core/themes/app_text.dart';


ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: AppTextStyles.fontFamily,

  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.amber100,
    onPrimary: AppColors.amber900,
    primaryContainer: AppColors.amber800,
    onPrimaryContainer: AppColors.amber100,
    secondary: AppColors.teal400,
    onSecondary: AppColors.teal800,
    secondaryContainer: const Color(0xFF04342C),
    onSecondaryContainer: AppColors.teal400,
    surface: AppColors.darkSurface,
    onSurface: const Color(0xFFFAF0E6),
    surfaceContainerHighest: AppColors.darkBackground,
    error: const Color(0xFFF09595),
    onError: const Color(0xFF501313),
    outline: const Color(0xFF5A3A10),
    outlineVariant: const Color(0xFF3A2810),
  ),

  scaffoldBackgroundColor: AppColors.darkBackground,

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.amber100,
    elevation: 0,
    scrolledUnderElevation: 1,
    titleTextStyle: TextStyle(
      fontFamily: AppTextStyles.fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.amber100,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.amber100,
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

  // cardTheme: CardTheme(
  //   color: AppColors.darkCard,
  //   elevation: 0,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(16),
  //     side: const BorderSide(color: Color(0x305A3A10), width: 0.8),
  //   ),
  //   margin: const EdgeInsets.only(bottom: 10),
  // ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2C2018),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0x505A3A10)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0x505A3A10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.amber100, width: 1.5),
    ),
    hintStyle: const TextStyle(color: Color(0xFFC4865A)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.amber400,
      foregroundColor: AppColors.amber900,
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
    backgroundColor: AppColors.amber900,
    labelStyle: const TextStyle(
      color: AppColors.amber100,
      fontFamily: AppTextStyles.fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    side: const BorderSide(color: Color(0x507A3B00)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0x205A3A10),
    thickness: 0.8,
  ),
);
