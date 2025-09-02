import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/cubit_theme&language/language/langauge_view_model.dart';
import 'package:movieapproute/cubit_theme&language/language/language_states.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class AnimatedToggleButtonLanguage extends StatefulWidget {
  AnimatedToggleButtonLanguage({super.key});

  @override
  State<AnimatedToggleButtonLanguage> createState() => _AnimatedToggleButtonLanguageState();
}

class _AnimatedToggleButtonLanguageState
    extends State<AnimatedToggleButtonLanguage> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocBuilder<LanguageViewModel, LanguageState>(
      builder: (context, state) {
        String currentLang = 'en';
        if (state is LanguageChangeState) {
          currentLang = state.languageCode;
        }
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
              [AppColors.yellowColor]
            ],
            inactiveBgColor: AppColors.transparentColor,
            totalSwitches: 2,
            customWidgets: [
              Image.asset(AppAssets.iconUsFlag, scale: 0.8),
              Image.asset(AppAssets.iconEgyFlag, scale: 0.8)
            ],
            initialLabelIndex: currentLang == 'en' ? 0 : 1,
            radiusStyle: true,
            onToggle: (language) {
              if (language == 0) {
                context.read<LanguageViewModel>().changeLanguage('en');
              } else {
                context.read<LanguageViewModel>().changeLanguage('ar');
              }
            },
          ),
        );
      },
    );
  }
}
