import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/tabs/home/custom_movie_card.dart';
import 'package:movieapproute/ui/home/tabs/search/cubit/search_states.dart';
import 'package:movieapproute/ui/home/tabs/search/cubit/search_view_model.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/widgets/custom_text_field.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocProvider(
      create: (_) => SearchViewModel(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search bar
                BlocBuilder<SearchViewModel, SearchState>(
                  builder: (context, state) {
                    final viewModel = context.read<SearchViewModel>();
                    return CustomTextField(
                      controller: viewModel.searchController,
                      prefixIcon: Image.asset(
                        AppAssets.unSelectedSearchTabIcon,
                        color: Theme
                            .of(context)
                            .indicatorColor,
                      ),
                      hintText: AppLocalizations.of(context)!.search,
                      filledColor: AppColors.transparentColor,
                      onSubmitted: (value) {
                        viewModel.searchMovies(value);
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Results
                Expanded(
                  child: BlocBuilder<SearchViewModel, SearchState>(
                    builder: (context, state) {
                      final viewModel = context.read<SearchViewModel>();
                      if (state is SearchInitial) {
                        return Center(child: Text(
                          "Type to search",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge,
                        ),
                        );
                      } else if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchSuccess) {
                        final movies = state.movies;
                        if (movies.isEmpty) {
                          return Center(
                            child: Text(
                              "No results",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge,
                            ),
                          );
                        }
                        return GridView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                          ),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: width * 0.04,
                            childAspectRatio: 3 / 5,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return InkWell(
                                child: CustomMovieCard(movie: movie),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.movieDetailsRouteName,
                                      arguments: state.movies[index].id);
                                });
                          },
                        );
                      } else if (state is SearchError) {
                        return Center(
                          child: Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
