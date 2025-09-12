import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/model/api_responses/movie_response.dart';
import 'package:movieapproute/shared_preferences/shared_preferences.dart';
import 'package:movieapproute/ui/home/tabs/search/cubit/search_states.dart';

class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel() : super(SearchInitial());
  TextEditingController searchController = TextEditingController();
  List<Movies> movies = [];
  String? lastQuery;

  Future<void> searchMovies(String query) async {
    query = query.trim();
    lastQuery = query;
    searchController.text = query;
    await SharedPreferencesAll().saveLastSearch(query);
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      var response = await ApiManager.searchMovies(query: query);
      movies = response.data?.movies ?? [];
      emit(SearchSuccess(movies));
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }
}
