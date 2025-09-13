import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/tabs/profile/watch_list/cubit/view_model.dart';
import 'package:movieapproute/ui/home/tabs/profile/watch_list/cubit/watch_list_states.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';

import '../../../../../utils/app_routes.dart';
import '../../home/custom_movie_card.dart';

class WatchList extends StatefulWidget {
  WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  WatchListViewModel viewModel = WatchListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<WatchListViewModel, WatchListState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.yellowColor),
          );
        } else if (state is WatchSuccessState) {
          if (state.movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.popcorn),
                  SizedBox(height: height * 0.01),
                  Text(
                    AppLocalizations.of(context)!.no_movies,
                    style: AppStyles.bold20WhiteR.copyWith(
                      color: AppColors.yellowColor,
                    ),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.02,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.movieDetailsRouteName,
                    arguments: state.movies[index].id,
                  );
                },
                child: CustomMovieCard(movie: state.movies[index]),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: width * 0.03,
              childAspectRatio: 3 / 5,
            ),
            itemCount: state.movies.length,
          );
        } else if (state is WatchErrorState) {
          return Center(
            child: Text(state.message, style: AppStyles.semiBold20Yellow),
          );
        }
        return Container();
      },
    );
  }
}