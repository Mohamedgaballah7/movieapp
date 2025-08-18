
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class AnimatedToggleButtonLanguage extends StatefulWidget {
  const AnimatedToggleButtonLanguage({super.key});

  @override
  State<AnimatedToggleButtonLanguage> createState() => _AnimatedToggleButtonLanguageState();
}

class _AnimatedToggleButtonLanguageState extends State<AnimatedToggleButtonLanguage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: ToggleSwitch(
        borderColor: [AppColors.yellowColor,AppColors.yellowColor],
        borderWidth: 1,
        cornerRadius: 40.0,
        animate: true,
        minWidth: width*0.11,
        activeBgColors: [[AppColors.yellowColor], [AppColors.yellowColor]],
        inactiveBgColor: AppColors.transparentColor,
        totalSwitches: 2,
        customWidgets: [Image.asset(AppAssets.iconUsFlag,scale: 0.8,),Image.asset(AppAssets.iconEgyFlag,scale: 0.8,)],
        initialLabelIndex: 1,
        radiusStyle: true,
      ),
    );
  }
}
