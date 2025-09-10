import '../../../../../model/api_responses/movie_response.dart';

abstract class BrowseStates {}

class BrowseLoadingState extends BrowseStates {}

class BrowseSuccessState extends BrowseStates {
  List<Movies> filterMovies;

  BrowseSuccessState({required this.filterMovies});
}

class BrowseErrorState extends BrowseStates {
  String errorMessage;

  BrowseErrorState({required this.errorMessage});
}
