import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/cubit_theme&language/theme/app_state.dart';
import 'package:movieapproute/shared_preferences/shared_preferences.dart';

class ChangeTheme extends Cubit<ThemeState> {
  ChangeTheme(this.appTheme) : super(ThemeChangedState(appTheme));
  ThemeMode appTheme;

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    SharedPreferencesAll.saveTheme(appTheme == ThemeMode.light);
    emit(ThemeChangedState(appTheme));
  }

  bool get isDark {
    return appTheme == ThemeMode.dark;
  }
}
