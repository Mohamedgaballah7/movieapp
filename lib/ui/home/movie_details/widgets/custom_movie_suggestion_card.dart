import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapproute/model/api_responses/movie_suggestion_response.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';

class CustomMovieSuggestionCard extends StatelessWidget {
  MoviesSuggestion movie;

  CustomMovieSuggestionCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(width * 0.04),
          ),
          child: CachedNetworkImage(
            width: width * 0.3,
            fit: BoxFit.fill,
            imageUrl: movie.mediumCoverImage ?? '',
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(color: AppColors.yellowColor),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(width * 0.1),
            color: AppColors.greyLightColor.withOpacity(0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(movie.rating.toString(), style: AppStyles.medium14White),
              Icon(Icons.star, color: AppColors.yellowColor),
            ],
          ),
        ),
      ],
    );
  }
}
