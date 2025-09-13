import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/home/movie_details/cubit/movie_details_states.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(LoadingState());

  //todo: hold data & handle logic

  void getMovieDetails(movieId) async {
    var isFavourite = await ApiManager.getMovieIsFavorite(movieId);
    try {
      emit(LoadingState());
      var response = await ApiManager.getMovieDetails(movieId);
      var responseSimilar = await ApiManager.getMovieSuggestions(movieId);
      if (response.status == "ok") {
        emit(
          SuccessState(
              isFavourite: isFavourite,
              movie: response.data!.movie!,
              backGroundImage: response.data?.movie?.backgroundImage ?? '',
              movieName: response.data?.movie?.title ?? '',
              movieUrl: response.data?.movie?.url ?? '',
              year: response.data?.movie?.year ?? 0,
              likes: response.data?.movie?.likeCount ?? 0,
              time: response.data?.movie?.runtime ?? 0,
              rate: response.data?.movie?.rating ?? 0.0,
              screenShot1: response.data?.movie?.largeScreenshotImage1 ?? '',
              screenShot2: response.data?.movie?.largeScreenshotImage2 ?? '',
              screenShot3: response.data?.movie?.largeScreenshotImage3 ?? '',
              summary:
              response.data?.movie?.descriptionIntro ?? 'there is no summary',
              cast: response.data?.movie?.cast ?? [],
              genres: response.data?.movie?.genres ?? [],
              similarMovie: responseSimilar.data?.movies ?? []
          ),
        );
      } else {
        emit(ErrorState(message: response.statusMessage!));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> addMovieToFavorite(int movieId,
      String name,
      double rating,
      String imageURL,
      int year,) async {
    try {
      // emit(LoadingState());
      var isFavourite = await ApiManager.getMovieIsFavorite(movieId);
      var responseMovie = await ApiManager.getMovieDetails(movieId);
      var responseSimilar = await ApiManager.getMovieSuggestions(movieId);
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
                isFavourite: !isFavourite,
                movie: responseMovie.data!.movie!,
                backGroundImage: responseMovie.data?.movie?.backgroundImage ??
                    '',
                movieName: responseMovie.data?.movie?.title ?? '',
                movieUrl: responseMovie.data?.movie?.url ?? '',
                year: responseMovie.data?.movie?.year ?? 0,
                likes: responseMovie.data?.movie?.likeCount ?? 0,
                time: responseMovie.data?.movie?.runtime ?? 0,
                rate: responseMovie.data?.movie?.rating ?? 0.0,
                screenShot1: responseMovie.data?.movie?.largeScreenshotImage1 ??
                    '',
                screenShot2: responseMovie.data?.movie?.largeScreenshotImage2 ??
                    '',
                screenShot3: responseMovie.data?.movie?.largeScreenshotImage3 ??
                    '',
                summary:
                responseMovie.data?.movie?.descriptionIntro ??
                    'there is no summary',
                cast: responseMovie.data?.movie?.cast ?? [],
                genres: responseMovie.data?.movie?.genres ?? [],
                similarMovie: responseSimilar.data?.movies ?? []
            )
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
    try {
      var response = await ApiManager.removeMovie(movieId);
      var isFavourite = await ApiManager.getMovieIsFavorite(movieId);
      var responseMovie = await ApiManager.getMovieDetails(movieId);
      var responseSimilar = await ApiManager.getMovieSuggestions(movieId);
      emit(LoadingState());
      if (response.message != null) {
        emit(
          //todo: success state
          SuccessState(
              isFavourite: isFavourite,
              movie: responseMovie.data!.movie!,
              backGroundImage: responseMovie.data?.movie?.backgroundImage ?? '',
              movieName: responseMovie.data?.movie?.title ?? '',
              movieUrl: responseMovie.data?.movie?.url ?? '',
              year: responseMovie.data?.movie?.year ?? 0,
              likes: responseMovie.data?.movie?.likeCount ?? 0,
              time: responseMovie.data?.movie?.runtime ?? 0,
              rate: responseMovie.data?.movie?.rating ?? 0.0,
              screenShot1: responseMovie.data?.movie?.largeScreenshotImage1 ??
                  '',
              screenShot2: responseMovie.data?.movie?.largeScreenshotImage2 ??
                  '',
              screenShot3: responseMovie.data?.movie?.largeScreenshotImage3 ??
                  '',
              summary:
              responseMovie.data?.movie?.descriptionIntro ??
                  'there is no summary',
              cast: responseMovie.data?.movie?.cast ?? [],
              genres: responseMovie.data?.movie?.genres ?? [],
              similarMovie: responseSimilar.data?.movies ?? []
          ),);
      } else {
        emit(ErrorState(message: response.message ?? ''));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}