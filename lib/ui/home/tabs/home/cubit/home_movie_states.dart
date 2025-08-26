import '../../../../../model/api_responses/movie_response.dart';

class HomeMovieStates{}

class HomeMovieLoadingState extends HomeMovieStates {}

class HomeMovieSuccessState extends HomeMovieStates {
   List<Movies> allMovies;
   List<Movies> actionMovies;

  HomeMovieSuccessState({required this.allMovies,required this.actionMovies});
}

class HomeMovieErrorState extends HomeMovieStates {
  String errorMessage;

  HomeMovieErrorState({required this.errorMessage});
}
