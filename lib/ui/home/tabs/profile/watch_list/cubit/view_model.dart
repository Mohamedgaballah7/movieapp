import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/ui/home/tabs/profile/watch_list/cubit/watch_list_states.dart';

import '../../../../../../api/api_manager.dart';
import '../../../../../../model/api_responses/movie_response.dart';

class WatchListViewModel extends Cubit<WatchListState> {
  WatchListViewModel() : super(LoadingState());

  List<Movies> moviesList = [];

  Future<void> getMovies() async {
    emit(LoadingState());

    try {
      var response = await ApiManager.getAllFavoritesMovies();
      if (response.data != null && response.data!.isNotEmpty) {
        moviesList = response.data!.map((movieMap) {
          return Movies(
            id: int.tryParse(movieMap['movieId'].toString()) ?? 0,
            title: movieMap['name'] ?? '',
            year: int.tryParse(movieMap['year'].toString()) ?? 0,
            rating: (movieMap['rating'] is int)
                ? (movieMap['rating'] as int).toDouble()
                : double.tryParse(movieMap['rating'].toString()) ?? 0.0,
            backgroundImage: movieMap['background_image'] ?? '',
          );
        }).toList();

        emit(WatchSuccessState(movies: moviesList));
      } else {
        emit(WatchErrorState(message: response.message!));
      }
    } catch (e) {
      emit(WatchErrorState(message: e.toString()));
    }
  }
}
