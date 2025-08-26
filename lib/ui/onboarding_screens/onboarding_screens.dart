import 'package:flutter/material.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/model/onboarding_model/onboarding_model.dart';
import 'package:movieapproute/shared_preferences/shared_preferences.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/custom_elevated_button.dart';

class OnboardingScreens extends StatefulWidget {
  OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
  final PageController pageController = PageController();
  int currentPage = 0;
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<OnboardingModel> onboardingScreens = [
      OnboardingModel(
        imagePath: AppAssets.moviePoster,
        title: AppLocalizations.of(context)!.find_your_next_favorite,
        description: AppLocalizations.of(context)!.get_access_library,
      ),
      OnboardingModel(
        imagePath: AppAssets.discoverMovies,
        title: AppLocalizations.of(context)!.discover_movies,
        description: AppLocalizations.of(context)!.explore_vast_collection,
      ),
      OnboardingModel(
        imagePath: AppAssets.exploreMovies,
        title: AppLocalizations.of(context)!.explore_all_genres,
        description: AppLocalizations.of(context)!.discover_movies_genre,
      ),
      OnboardingModel(
        imagePath: AppAssets.createWatchlists,
        title: AppLocalizations.of(context)!.create_watch_lists,
        description: AppLocalizations.of(context)!.save_movies_watchlist,
      ),
      OnboardingModel(
        imagePath: AppAssets.rateMovies,
        title: AppLocalizations.of(context)!.rate_review_learn,
        description: AppLocalizations.of(context)!.share_your_thoughts,
      ),
      OnboardingModel(
        imagePath: AppAssets.startWatching,
        title: AppLocalizations.of(context)!.start_watching_now,
      ),
    ];
    return Scaffold(
      body: PageView.builder(
        controller: widget.pageController,
        onPageChanged: (index) {
          setState(() {
            widget.currentPage = index;
          });
        },
        itemCount: onboardingScreens.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.asset(onboardingScreens[index].imagePath, fit: BoxFit.fill),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.1,
                    vertical: height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: index == 0
                        ? AppColors.transparentColor
                        : AppColors.blackColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        onboardingScreens[index].title,
                        style: AppStyles.bold24White,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height * 0.02),
                      if (onboardingScreens[index].description != null)
                        Text(
                          onboardingScreens[index].description!,
                          style: AppStyles.regular16White,
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: height * 0.02),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: () async {
                            if (index == onboardingScreens.length - 1) {
                              await SharedPreferencesAll().onBoardingScreen();
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.loginRouteName,
                              );
                            } else {
                              widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          text: index == 0
                              ? AppLocalizations.of(context)!.explore_now
                              : (index == onboardingScreens.length - 1
                                    ? AppLocalizations.of(context)!.get_started
                                    : AppLocalizations.of(context)!.next),
                          backgroundColor: AppColors.yellowColor,
                          textStyle: AppStyles.semiBold20Black,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      if (index != 0 && index != 1)
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: () {
                              widget.pageController.previousPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            text: AppLocalizations.of(context)!.back,
                            backgroundColor: Colors.transparent,
                            borderSideColor: AppColors.yellowColor,
                            textStyle: AppStyles.semiBold20Yellow,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
