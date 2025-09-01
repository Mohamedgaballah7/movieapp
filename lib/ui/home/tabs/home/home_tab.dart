import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/tabs/home/cubit/home_movie_states.dart';
import 'package:movieapproute/ui/home/tabs/home/custom_movie_card.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';

import 'cubit/home_movie_view_model.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();

}

class _HomeTabState extends State<HomeTab> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovie();
  }
  HomeMovieViewModel viewModel=HomeMovieViewModel();
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Scaffold(
      body:BlocBuilder<HomeMovieViewModel,HomeMovieStates>(
        bloc: viewModel,
          builder: (context, state) {
            //todo handle the success state
            if (state is HomeMovieSuccessState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: 0.4,
                          child: CachedNetworkImage(
                            imageUrl: state.allMovies[viewModel.selectedIndex]
                                .largeCoverImage ?? '',
                            placeholder: (context, url) =>
                                Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.yellowColor,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width *
                                0.02),
                            child: Column(
                              children: [
                                Image.asset(AppAssets.availableNow),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width *
                                          0.02),
                                  child:
                                  SizedBox(
                                    height: height * 0.4,
                                    child: PageView.builder(
                                      controller: PageController(
                                        viewportFraction: 0.6,
                                      ),
                                      itemCount: state.allMovies.length,
                                      onPageChanged: (index) {
                                        setState(() {
                                          viewModel.selectedIndex = index;
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                        bool isSelected = index ==
                                            viewModel.selectedIndex;

                                        return Transform.scale(
                                          scale: isSelected ? 0.9 : 0.7,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: isSelected ? 0 : 5,
                                            ),
                                            child: CustomMovieCard(
                                              movie: state.allMovies[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                ),
                                Image.asset(AppAssets.watchNow),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.action,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelLarge),
                          TextButton(
                            onPressed: () {
                              //todo:make action movies swipe
                              viewModel.actionScrollController.animateTo(
                                viewModel.actionScrollController.offset +
                                    (width * 0.4),
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Row(
                              children: [
                                Text(AppLocalizations.of(context)!.see_more,
                                    style: AppStyles.bold14Yellow),
                                SizedBox(width: width * 0.01),
                                Icon(Icons.arrow_forward,
                                    color: AppColors.yellowColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: SizedBox(
                        height: height * 0.2,
                        child: ListView.separated(
                            controller: viewModel.actionScrollController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CustomMovieCard(
                                  movie: state.actionMovies[index]);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: width * 0.02,);
                            },
                            itemCount: state.actionMovies.length
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,)
                  ],
                ),
              );
            }
            //todo handle the error server state
            if (state is HomeMovieErrorState) {
              return Center(
                  child: Text(
                      "Error: ${state.errorMessage}",
                      style: AppStyles.bold14Yellow));
            }
            //todo handle the loading state
            return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                )
            );
          }
    )
    );
  }
}
