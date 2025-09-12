import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/model/api_responses/movie_response.dart';
import 'package:movieapproute/ui/home/tabs/home/custom_movie_card.dart';
import 'package:movieapproute/ui/home/tabs/profile/watch_list/cubit/view_model.dart';
import 'package:movieapproute/ui/home/tabs/profile/watch_list/cubit/watch_list_states.dart';
import 'package:movieapproute/utils/app_colors.dart';

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
    viewModel.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchListViewModel, WatchListState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is SuccessState) {
          /*List<Movies> movies =
          state.movies.map((item) => Movies.fromJson(item)).toList();*/
          return SizedBox(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 4,
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                List<Movies> movies = state.movies
                    .map(
                      (item) => Movies.fromJson(item as Map<String, dynamic>),
                    )
                    .toList();
                return CustomMovieCard(movie: movies[index]);
              },
            ),
          );
        } else if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.yellowColor),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Column(
              children: [
                Text(state.message),
                ElevatedButton(onPressed: () {}, child: Text('try again')),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
