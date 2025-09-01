import 'package:flutter/material.dart';

abstract class ThemeState {}

class ThemeChangedState extends ThemeState {
  final ThemeMode themeMode;

  ThemeChangedState(this.themeMode);
}
