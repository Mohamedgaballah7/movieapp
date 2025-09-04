import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class CustomScreenShotsImages extends StatelessWidget {
  CustomScreenShotsImages({super.key, required this.imagePath, this.height});

  String imagePath;
  double? height;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(width * 0.02),
      child: CachedNetworkImage(
        height: height,
        imageUrl: imagePath,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(color: AppColors.yellowColor),
        ),
      ),
    );
  }
}
