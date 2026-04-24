import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/core/themes/dark_theme.dart';
import 'package:pms/core/themes/light_theme.dart';
class ThemeCubit extends Cubit<ThemeData> {
  bool _isDarkMode = false;

  ThemeCubit() : super(lightTheme);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    if (_isDarkMode) {
      emit(darkTheme);
    } else {
      emit(lightTheme);
    }
  }
}
