

abstract class WatchListState {}

class LoadingState extends WatchListState {}

class WatchSuccessState extends WatchListState {
  List<dynamic> movies;

  WatchSuccessState({required this.movies});
}

class WatchErrorState extends WatchListState {
  String message;

  WatchErrorState({required this.message});
}
