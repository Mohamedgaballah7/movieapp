import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';

class CustomCastContainer extends StatelessWidget {
  String imagePath;
  String name;
  String character;

  CustomCastContainer({
    super.key,
    required this.imagePath,
    required this.name,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: width * 0.025,
        vertical: height * 0.008,
      ),
      width: double.infinity,
      height: height * 0.09,
      decoration: BoxDecoration(
        color: AppColors.greyDarkColor,
        borderRadius: BorderRadiusGeometry.circular(width * 0.037),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(width * 0.02),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: width * 0.15,
            ),
          ),
          SizedBox(width: width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Name: $name', style: AppStyles.medium16White),
              Text('Character: $character', style: AppStyles.medium16White),
            ],
          ),
        ],
      ),
    );
  }
}
