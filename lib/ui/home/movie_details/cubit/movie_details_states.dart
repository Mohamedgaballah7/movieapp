import 'package:movieapproute/model/api_responses/movie_details_response.dart';

abstract class MovieDetailsStates {}

//class InitialeState extends MovieDetailsStates{}
class LoadingState extends MovieDetailsStates {
  //todo: this is the initial state
}

class SuccessState extends MovieDetailsStates {
  //todo: movieDetails API data
  String backGroundImage;
  String movieName;
  int year;
  int likes;
  int time;
  double rate;
  String screenShot1;
  String screenShot2;
  String screenShot3;
  String summary;
  List<Cast> cast;
  List<String> genres;

  SuccessState({
    required this.backGroundImage,
    required this.movieName,
    required this.year,
    required this.likes,
    required this.time,
    required this.rate,
    required this.screenShot1,
    required this.screenShot2,
    required this.screenShot3,
    required this.summary,
    required this.cast,
    required this.genres,
  });
  //todo: movieSuggestion API data
}

class ErrorState extends MovieDetailsStates {
  String message;

  ErrorState({required this.message});
}
