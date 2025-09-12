import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/home/movie_details/cubit/movie_details_states.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(LoadingState());

  //todo: hold data & handle logic

  void getMovieDetails(movieId) async {
    final movie = await ApiManager.getMovieDetails(movieId);
    var response = await ApiManager.getMovieDetails(movieId);
    var responseSimilar = await ApiManager.getMovieSuggestions(movieId);
    var isFavoriteResponse = await ApiManager.getMovieIsFavorite(movieId);
    var dataResponse = isFavoriteResponse.data;
    var removeFavoriteResponse = await ApiManager.removeMovie(movieId);
    var removeMessage = removeFavoriteResponse.message;
    try {
      emit(LoadingState());

      if (response.status == "ok") {
        emit(
          SuccessState(

            removeMessage: removeMessage ?? '',
            backGroundImage: movie.data?.movie?.backgroundImage ?? '',
            data: dataResponse ?? false,
            movieName: movie.data?.movie?.title ?? '',
            movieUrl: movie.data?.movie?.url ?? '',
            year: movie.data?.movie?.year ?? 0,
            likes: movie.data?.movie?.likeCount ?? 0,
            time: movie.data?.movie?.runtime ?? 0,
            rate: movie.data?.movie?.rating ?? 0.0,
            screenShot1: movie.data?.movie?.largeScreenshotImage1 ?? '',
            screenShot2: movie.data?.movie?.largeScreenshotImage2 ?? '',
            screenShot3: movie.data?.movie?.largeScreenshotImage3 ?? '',
            summary:
                movie.data?.movie?.descriptionFull ?? 'there is no summary',
            cast: movie.data?.movie?.cast ?? [],
            genres: movie.data?.movie?.genres ?? [],
            similarMovie: responseSimilar.data?.movies ?? [],
          ),
        );
      } else {
        emit(ErrorState(message: response.statusMessage!));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  //todo: add movie to favorite
  Future<void> addMovieToFavorite(
    int movieId,
    String name,
    double rating,
    String imageURL,
    int year,
  ) async {
    final movie = await ApiManager.getMovieDetails(movieId);
    var responseSimilar = await ApiManager.getMovieSuggestions(movieId);
    var isFavoriteResponse = await ApiManager.getMovieIsFavorite(movieId);
    var dataResponse = isFavoriteResponse.data;
    var removeFavoriteResponse = await ApiManager.removeMovie(movieId);
    var removeMessage = removeFavoriteResponse.message;
    try {
      emit(LoadingState());
      var response = await ApiManager.addMovieToFavorite(
        movieId,
        name,
        rating,
        imageURL,
        year,
      );
      if (response.message == 'Added to favourite successfully') {
        emit(
          //todo: success state
          SuccessState(
            removeMessage: removeMessage ?? '',
            backGroundImage: movie.data?.movie?.backgroundImage ?? '',
            data: dataResponse ?? false,
            movieName: movie.data?.movie?.title ?? '',
            movieUrl: movie.data?.movie?.url ?? '',
            year: movie.data?.movie?.year ?? 0,
            likes: movie.data?.movie?.likeCount ?? 0,
            time: movie.data?.movie?.runtime ?? 0,
            rate: movie.data?.movie?.rating ?? 0.0,
            screenShot1: movie.data?.movie?.largeScreenshotImage1 ?? '',
            screenShot2: movie.data?.movie?.largeScreenshotImage2 ?? '',
            screenShot3: movie.data?.movie?.largeScreenshotImage3 ?? '',
            summary:
                movie.data?.movie?.descriptionFull ?? 'there is no summary',
            cast: movie.data?.movie?.cast ?? [],
            genres: movie.data?.movie?.genres ?? [],
            similarMovie: responseSimilar.data?.movies ?? [],
          ),
        );
      } else {
        emit(ErrorState(message: response.message!));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  //todo: remove movie from favorite
  Future<void> removeMovie(int movieId) async {
    final movie = await ApiManager.getMovieDetails(movieId);
    var responseSimilar = await ApiManager.getMovieSuggestions(movieId);
    var isFavoriteResponse = await ApiManager.getMovieIsFavorite(movieId);
    var dataResponse = isFavoriteResponse.data;
    var removeFavoriteResponse = await ApiManager.removeMovie(movieId);
    var removeMessage = removeFavoriteResponse.message;
    try {
      emit(LoadingState());
      var response = await ApiManager.removeMovie(movieId);

      if (response.message != null) {
        emit(
          //todo: success state
          SuccessState(
            removeMessage: removeMessage ?? '',
            backGroundImage: movie.data?.movie?.backgroundImage ?? '',
            data: dataResponse ?? false,
            movieName: movie.data?.movie?.title ?? '',
            movieUrl: movie.data?.movie?.url ?? '',
            year: movie.data?.movie?.year ?? 0,
            likes: movie.data?.movie?.likeCount ?? 0,
            time: movie.data?.movie?.runtime ?? 0,
            rate: movie.data?.movie?.rating ?? 0.0,
            screenShot1: movie.data?.movie?.largeScreenshotImage1 ?? '',
            screenShot2: movie.data?.movie?.largeScreenshotImage2 ?? '',
            screenShot3: movie.data?.movie?.largeScreenshotImage3 ?? '',
            summary:
                movie.data?.movie?.descriptionFull ?? 'there is no summary',
            cast: movie.data?.movie?.cast ?? [],
            genres: movie.data?.movie?.genres ?? [],
            similarMovie: responseSimilar.data?.movies ?? [],
          ),
        );
      } else {
        emit(ErrorState(message: response.message ?? ''));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
