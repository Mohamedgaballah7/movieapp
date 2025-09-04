import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/home/movie_details/cubit/movie_details_states.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(LoadingState());

  //todo: hold data & handle logic

  void getMovieDetails(movieId) async {
    try {
      emit(LoadingState());
      var response = await ApiManager.getMovieDetails(movieId);
      var responseSimilar = await ApiManager.getMovieSuggestions(movieId);
      if (response.status == "ok") {
        emit(
          SuccessState(
            backGroundImage: response.data?.movie?.backgroundImageOriginal ?? '',
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
}
