import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/tabs/browse/cubit/browse_states.dart';

class BrowseViewModel extends Cubit<BrowseStates> {
  BrowseViewModel() : super(BrowseLoadingState());
  int selectedIndex = 0;

  List<String> getLocalizedImdbGenres(BuildContext context) {
    return [
      AppLocalizations.of(context)!.action,
      AppLocalizations.of(context)!.adventure,
      AppLocalizations.of(context)!.animation,
      AppLocalizations.of(context)!.biography,
      AppLocalizations.of(context)!.comedy,
      AppLocalizations.of(context)!.crime,
      AppLocalizations.of(context)!.documentary,
      AppLocalizations.of(context)!.drama,
      AppLocalizations.of(context)!.family,
      AppLocalizations.of(context)!.fantasy,
      AppLocalizations.of(context)!.film_noir,
      AppLocalizations.of(context)!.game_show,
      AppLocalizations.of(context)!.history,
      AppLocalizations.of(context)!.horror,
      AppLocalizations.of(context)!.musical,
      AppLocalizations.of(context)!.music,
      AppLocalizations.of(context)!.mystery,
      AppLocalizations.of(context)!.news,
      AppLocalizations.of(context)!.reality_tv,
      AppLocalizations.of(context)!.romance,
      AppLocalizations.of(context)!.sci_fi,
      AppLocalizations.of(context)!.short,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.talk_show,
      AppLocalizations.of(context)!.thriller,
      AppLocalizations.of(context)!.war,
      AppLocalizations.of(context)!.western,
    ];
  }

  final List<String> imdbGenres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Film Noir",
    "Game Show",
    "History",
    "Horror",
    "Musical",
    "Music",
    "Mystery",
    "News",
    "Reality-TV",
    "Romance",
    "Sci-Fi",
    "Short",
    "Sport",
    "Talk-Show",
    "Thriller",
    "War",
    "Western",
  ];

  //todo: handle Logic " states holds the data"
  void getFilterMovie() async {
    try {
      emit(BrowseLoadingState());
      var filterMoviesResponse = await ApiManager.getMovies(
        genre: imdbGenres[selectedIndex],
      );
      //todo handle the success state
      if (filterMoviesResponse.status == "ok") {
        emit(
          BrowseSuccessState(
            filterMovies: filterMoviesResponse.data?.movies ?? [],
          ),
        );
      }
      //todo handle the error server state
      else if (filterMoviesResponse.status != "ok") {
        emit(
          BrowseErrorState(errorMessage: filterMoviesResponse.statusMessage!),
        );
      }
      //todo handle the error client state
    } catch (e) {
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }
}
