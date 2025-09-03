import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class CustomReactTimeLikeContainer extends StatelessWidget {
  double width;
  String text;
  IconData icon;

  CustomReactTimeLikeContainer({
    super.key,
    required this.width,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.07,
        vertical: width * 0.01,
      ),
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(width * 0.02),
        color: AppColors.greyDarkColor,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.yellowColor),
          SizedBox(width: width * 0.01),
          Text(text, style: AppStyles.bold16White),
        ],
      ),
    );
  }
}
