import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/ui/home/tabs/browse/cubit/browse_states.dart';
import 'package:movieapproute/ui/home/tabs/browse/cubit/browse_view_model.dart';
import 'package:movieapproute/ui/home/tabs/browse/genres_items.dart';
import 'package:movieapproute/ui/home/tabs/home/custom_movie_card.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();

}

class _BrowseTabState extends State<BrowseTab> {
  BrowseViewModel viewModel = BrowseViewModel();

  @override
  void initState() {
    // TODO: implement initState
    viewModel.selectedIndex;
    viewModel.getFilterMovie();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: BlocBuilder<BrowseViewModel, BrowseStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is BrowseSuccessState) {
            return
              Scaffold(
                appBar: AppBar(
                  scrolledUnderElevation: 0,
                  title: DefaultTabController(
                      length: viewModel.imdbGenres.length,
                      child:
                      TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          dividerColor: AppColors.transparentColor,
                          labelPadding: EdgeInsets.zero,
                          indicatorColor: AppColors.transparentColor,
                          onTap: (index) {
                            setState(() {
                              viewModel.selectedIndex = index;
                              viewModel.getFilterMovie();
                            });
                          },
                          tabs: List.generate(
                            viewModel.imdbGenres.length, (index) {
                            final genre = viewModel.getLocalizedImdbGenres(
                                context)[index];
                            return GenresItems(
                              selectedBorderColor: AppColors.transparentColor,
                              unSelectedBorderColor: AppColors.yellowColor,
                              selectedBackGroundColor: AppColors.yellowColor,
                              unSelectedBackGroundColor: AppColors
                                  .transparentColor,
                              selectedTextStyle: AppStyles.bold16Black,
                              unSelectedTextStyle: AppStyles.bold16Black
                                  .copyWith(
                                  color: AppColors.yellowColor
                              ),
                              isSelected: viewModel.selectedIndex == index,
                              genreName: genre,
                            );
                          },).toList()
                      )
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: state.filterMovies.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: width * 0.04,
                          childAspectRatio: 3 / 5,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(
                                    AppRoutes
                                        .movieDetailsRouteName,
                                    arguments: state
                                        .filterMovies[index].id);
                              },
                              child: CustomMovieCard(
                                  movie: state.filterMovies[index]));
                        },

                      ),
                    )

                  ],
                ),
              );
          }
          else if (state is BrowseErrorState) {
            return Center(
                child: Text(
                    "Error: ${state.errorMessage}",
                    style: AppStyles.bold14Yellow));
          }
          else {
            return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                )
            );
          }
        },
      ),
    );

  }
}
