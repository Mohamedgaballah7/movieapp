import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapproute/ui/home/movie_details/widgets/custom_react_time_like_container.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/custom_elevated_button.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.discoverMovies),

                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Column(
                    spacing: height * 0.1,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Image.asset(AppAssets.watchListIcon),
                        ],
                      ),
                      Image.asset(AppAssets.videoPlayIcon),
                      Text(
                        'Doctor Strange in the Multiverse of Madness',
                        style: AppStyles.bold16White,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                spacing: height * 0.02,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text('2020', style: AppStyles.medium12Gray)),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      backgroundColor: AppColors.redColor,
                      onPressed: () {},
                      text: 'Watch',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomReactTimeLikeContainer(
                        width: width,
                        text: '15',
                        icon: CupertinoIcons.heart_solid,
                      ),
                      CustomReactTimeLikeContainer(
                        width: width,
                        text: '90',
                        icon: CupertinoIcons.clock_fill,
                      ),
                      CustomReactTimeLikeContainer(
                        width: width,
                        text: '7.6',
                        icon: CupertinoIcons.star_fill,
                      ),
                    ],
                  ),
                  Text('Screen Shots', style: AppStyles.bold16White),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(width * 0.02),
                    child: Image.asset(
                      AppAssets.exploreMovies,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: height * 0.2,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(width * 0.02),
                    child: Image.asset(
                      AppAssets.exploreMovies,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: height * 0.2,
                    ),
                  ),
                  Text('Similar', style: AppStyles.bold16White),
                  Text('Summary', style: AppStyles.bold16White),
                  Text(
                    'Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346',
                    style: AppStyles.medium14White,
                  ),
                  Text('Cast', style: AppStyles.bold16White),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
