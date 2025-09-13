import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapproute/api/api_constants.dart';
import 'package:movieapproute/api/api_endpoints.dart';
import 'package:movieapproute/model/api_responses/add_movie_to_favorite_response.dart';
import 'package:movieapproute/model/api_responses/get_all_favorite_movies_response.dart';
import 'package:movieapproute/model/api_responses/login_response.dart';
import 'package:movieapproute/model/api_responses/movie_details_response.dart';
import 'package:movieapproute/model/api_responses/register_response.dart';
import 'package:movieapproute/model/api_responses/remove_movie_response.dart';
import 'package:movieapproute/model/api_responses/reset_password_response.dart';
import 'package:movieapproute/shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api_responses/movie_response.dart';
import '../model/api_responses/movie_suggestion_response.dart';
import '../model/api_responses/profile_response.dart';

class ApiManager {
  //todo: register auth
  static Future<RegisterResponse> postRegisterData(String name,
      String email,
      String password,
      String confirmPassword,
      String phone,
      int avatarId,) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.registerEndPoint);
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "phone": phone,
          "avaterId": avatarId,
        }),
      );

      var responseBody = response.body; //todo: string
      var json = jsonDecode(responseBody); //todo: json
      return RegisterResponse.fromJson(json); //todo: dart obj
    } catch (e) {
      throw e;
    }
  }

  //todo: get movies
  static Future<MovieResponse> getMovies({String? genre}) async {
    var url = Uri.https(ApiConstants.movieBaseUrl, ApiEndPoints.movieEndPoint, {
      'genre': genre,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MovieResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // todo: login auth
  static Future<LoginResponse> postLoginData(String email,
      String password,) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.loginEndPoint);
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
        }),
      );
      var responseBody = response.body; //todo: string
      var json = jsonDecode(responseBody); //todo: json
      var loginResponse = LoginResponse.fromJson(json); //todo: dart obj
      if (loginResponse.data != null && loginResponse.data!.isNotEmpty) {
        await SharedPreferencesAll.saveToken(loginResponse.data!);
        print("Token saved: ${loginResponse.data}");
      } else {
        print("No token found in response");
      }
      return loginResponse;
    } catch (e) {
      throw e;
    }
  }

  //todo: getProfile
  static Future<ProfileResponse> getUserData() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.profileEndPoint);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");

      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return ProfileResponse.fromJson(json);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  //todo: deleteProfile
  static Future<ProfileResponse> deleteProfile() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.profileEndPoint);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");

      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      var responseBody = response.body; //todo: string
      var json = jsonDecode(responseBody); //todo: json
      return ProfileResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<ProfileResponse> updateProfile({
    String? name,
    int? avatarId,
    String? phoneNumber,
  }) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.profileEndPoint);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");

      var response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          if (name != null) "name": name,
          if (avatarId != null) "avaterId": avatarId,
          if (phoneNumber != null) "phone": phoneNumber,
        }),
      );

      var responseBody = response.body; //todo: string
      var json = jsonDecode(responseBody); //todo: json
      return ProfileResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  //todo: reset password
  static Future<ResetPasswordResponse> patchResetPassword(String oldPassword,
      String newPassword,) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiEndPoints.resetPasswordEndPoint,
    );
    try {
      String? token = await SharedPreferencesAll.getToken();
      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }
      ResetPasswordResponse requestBody = ResetPasswordResponse(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      var response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody.toJson()),
      );
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var resetResponse = ResetPasswordResponse.fromJson(json);
      return resetResponse;
    } catch (e) {
      throw e;
    }
  }

  //todo : getMovieDetails
  static Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    Uri url = Uri.https(
      ApiConstants.movieBaseUrl,
      ApiEndPoints.movieDetailsEndPoint,
      {
        'movie_id': movieId.toString(),
        'with_images': true.toString(),
        'with_cast': true.toString(),
      },
    );
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MovieDetailsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  //todo : get movie suggestions
  static Future<MovieSuggestionResponse> getMovieSuggestions(
      int movieId,) async {
    Uri url = Uri.https(
      ApiConstants.movieBaseUrl,
      ApiEndPoints.movieSuggestionsEndPoint,
      {'movie_id': movieId.toString()},
    );
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MovieSuggestionResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  //todo: search movies
  static Future<MovieResponse> searchMovies({String? query}) async {
    var url = Uri.https(
      ApiConstants.movieBaseUrl,
      ApiEndPoints.movieEndPoint,
      {
        'query_term': query,
      },
    );

    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      return MovieResponse.fromJson(jsonData);
    } catch (e) {
      throw e;
    }
  }static Future<AddMovieToFavoriteResponse> addMovieToFavorite(int movieId,
      String name,
      double rating,
      String imageURL,
      int year,) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiEndPoints.addMovieToFavoriteEndPoint,
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "movieId": movieId,
          "name": name,
          "rating": rating,
          "imageURL": imageURL,
          "year": year,
        }),
      );
      var responseBody = response.body; //todo: String
      var json = jsonDecode(responseBody);
      return AddMovieToFavoriteResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<RemoveMovieResponse> removeMovie(int movieId) async {
    Uri url = Uri.https(ApiConstants.baseUrl,
        "/favorites/remove/$movieId");
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");

      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      var responseBody = response.body; //todo: string
      var json = jsonDecode(responseBody); //todo: json
      return RemoveMovieResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }static Future<GetAllFavoriteMoviesResponse> getAllFavoritesMovies() async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiEndPoints.getAllFavoritesMoviesEndPoint,
    );
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("authToken");

    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GetAllFavoriteMoviesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }

  static Future<bool> getMovieIsFavorite(int movieId) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      "/favorites/is-favorite/$movieId",
    );
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("authToken");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return json["data"] as bool;
    } catch (e) {
      rethrow;
    }
  }
  }

