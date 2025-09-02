import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';

class CustomGenresContainer extends StatelessWidget {
  String type;

  CustomGenresContainer({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: width * 0.025),
      alignment: Alignment.center,
      width: width * 0.283,
      height: height * 0.038,
      decoration: BoxDecoration(
        color: AppColors.greyDarkColor,
        borderRadius: BorderRadiusGeometry.circular(width * 0.0279),
      ),
      child: Text('$type', style: AppStyles.medium16White),
    );
  }
}
