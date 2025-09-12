

abstract class WatchListState {}

class LoadingState extends WatchListState {}

class SuccessState extends WatchListState {
  List<dynamic> movies;

  SuccessState({required this.movies});
}

class ErrorState extends WatchListState {
  String message;

  ErrorState({required this.message});
}
