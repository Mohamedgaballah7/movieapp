import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/model/api_responses/movie_details_response.dart';
import 'package:movieapproute/ui/home/movie_details/cubit/movie_details_states.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(LoadingState());

  //todo: hold data & handle logic

  Future<MovieDetailsResponse?> getMovieDetails(movieId) async {
    try {
      emit(LoadingState());
      var response = await ApiManager.getMovieDetails(movieId);
      if (response.status == "ok") {
        emit(
          SuccessState(
            backGroundImage: response.data?.movie?.backgroundImage ?? '',
            movieName: response.data?.movie?.title ?? '',
            year: response.data?.movie?.year ?? 0,
            likes: response.data?.movie?.likeCount ?? 0,
            time: response.data?.movie?.runtime ?? 0,
            rate: response.data?.movie?.rating ?? 0,
            screenShot1: response.data?.movie?.largeScreenshotImage1 ?? '',
            screenShot2: response.data?.movie?.largeScreenshotImage2 ?? '',
            screenShot3: response.data?.movie?.largeScreenshotImage3 ?? '',
            summary:
                response.data?.movie?.descriptionIntro ?? 'there is no summary',
            cast: response.data?.movie?.cast ?? [],
            genres: response.data?.movie?.genres ?? [],
          ),
        );
      } else {
        emit(ErrorState(message: response.statusMessage!));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
    return null;
  }
}
