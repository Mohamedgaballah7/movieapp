
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color? backgroundColor;
  Color? borderSideColor;
  bool hasIcon;
  Widget? iconWidget;
  TextStyle? textStyle;
  MainAxisAlignment? mainAxisAlignment;

  CustomElevatedButton({super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.yellowColor,
    this.borderSideColor = AppColors.transparentColor,
    this.hasIcon = false,
    this.iconWidget,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: height * 0.015,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: borderSideColor?? AppColors.transparentColor,
            width: 1,
          ),
        ),
      ),
        onPressed: onPressed,
        child: hasIcon ?
            Row(
              mainAxisAlignment: mainAxisAlignment!,
              children: [
                Text(text, style: textStyle),
                SizedBox(width: width * 0.02,),
                iconWidget!,

              ],
            ):
            Text(text, style: textStyle?? AppStyles.medium20Black,),
    );
  }
}
