import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/home/tabs/home/cubit/home_movie_states.dart';

class HomeMovieViewModel extends Cubit<HomeMovieStates> {
  HomeMovieViewModel() : super(HomeMovieLoadingState());

  //todo: handle Logic " states holds the data"
  void getMovie() async{
    try {
      emit(HomeMovieLoadingState());
      var allMoviesResponse = await ApiManager.getMovies();
      var actionMoviesResponse = await ApiManager.getMovies(genre: 'Action');
      //todo handle the success state
      if (allMoviesResponse.status == "ok") {
        emit(HomeMovieSuccessState(
          allMovies: allMoviesResponse.data?.movies ?? [],
          actionMovies: actionMoviesResponse.data?.movies ?? [],
        ));
      }
      //todo handle the error server state
      else if (allMoviesResponse.status != "ok") {
        emit(HomeMovieErrorState(errorMessage: allMoviesResponse.statusMessage!));

      }
      //todo handle the error client state
    } catch (e) {
      emit(HomeMovieErrorState(errorMessage: e.toString()));
    }
  }
}
