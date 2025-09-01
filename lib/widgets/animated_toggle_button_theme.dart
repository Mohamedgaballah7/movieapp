import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../cubit_theme&language/theme/theme_view_model.dart';
import '../utils/app_colors.dart';

class AnimatedToggleButtonTheme extends StatefulWidget {
  const AnimatedToggleButtonTheme({super.key});

  @override
  State<AnimatedToggleButtonTheme> createState() =>
      _AnimatedToggleButtonThemeState();
}

class _AnimatedToggleButtonThemeState extends State<AnimatedToggleButtonTheme> {
  @override
  Widget build(BuildContext context) {
    var themeModel = context.read<ChangeTheme>();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: ToggleSwitch(
        animationDuration: 200,
        borderColor: [AppColors.yellowColor, AppColors.yellowColor],
        borderWidth: 2,
        cornerRadius: 40.0,
        animate: true,
        minWidth: width * 0.11,
        activeBgColors: [
          [AppColors.yellowColor],
          [AppColors.yellowColor],
        ],
        inactiveBgColor: AppColors.transparentColor,
        totalSwitches: 2,
        customWidgets: [
          Icon(Icons.nightlight_round_outlined),
          Icon(Icons.sunny),
        ],
        initialLabelIndex: themeModel.appTheme == ThemeMode.dark ? 0 : 1,
        radiusStyle: true,
        onToggle: (theme) {
          if (theme == 0) {
            themeModel.changeTheme(ThemeMode.dark);
          } else {
            themeModel.changeTheme(ThemeMode.light);
          }
        },
      ),
    );
  }
}
