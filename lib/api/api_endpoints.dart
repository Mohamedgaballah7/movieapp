class ApiEndPoints {
  static const String registerEndPoint = '/auth/register';
  static const String movieEndPoint = '/api/v2/list_movies.json';
  static const String movieDetailsEndPoint = '/api/v2/movie_details.json';
  static const String loginEndPoint = '/auth/login';
  static const String profileEndPoint = '/profile';
  static const String resetPasswordEndPoint = '/auth/reset-password';
  static const String movieSuggestionsEndPoint =
      '/api/v2/movie_suggestions.json';
  static const String addMovieToFavoriteEndPoint = "/favorites/add";
  static const String removeMovieEndPoint = "/favorites/remove/movieId";
  static const String getAllFavoritesMoviesEndPoint = "/favorites/all";
  static const String getMovieIsFavoriteEndPoint =
      "/favorites/is-favorite/movieId";
}

