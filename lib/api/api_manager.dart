import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieapproute/api/api_constants.dart';
import 'package:movieapproute/api/api_endpoints.dart';
import 'package:movieapproute/model/api_responses/login_response.dart';
import 'package:movieapproute/model/api_responses/register_response.dart';
import 'package:movieapproute/shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_responses/profile_response.dart';

import '../model/api_responses/movie_response.dart';

class ApiManager {

  //todo: register auth
  static Future<RegisterResponse> postRegisterData(String name,
      String email,
      String password,
      String confirmPassword,
      String phone,
      int avatarId,) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiEndPoints.registerEndPoint,
    );
    try {
      var response = await http.post(
        url, headers: <String, String>{
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
  static Future<MovieResponse> getMovies({String? genre})async{
    var url = Uri.https(
        ApiConstants.movieBaseUrl,
        ApiEndPoints.movieEndPoint,{
        'genre': genre,
    }
    );
    try{
      var response=await http.get(url);
      var responseBody=response.body;
      var json=jsonDecode(responseBody);
      return MovieResponse.fromJson(json);
    }
    catch(e){
      throw e;
    }

  }
  // todo: login auth
  static Future<LoginResponse> postLoginData(String email,
      String password,) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.loginEndPoint);
    try {
      var response = await http.post(
        url, headers: <String, String>{
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
    Uri url = Uri.https(
        ApiConstants.baseUrl, ApiEndPoints.profileEndPoint);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");

      var response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return ProfileResponse.fromJson(json);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }

  //todo: deleteProfile
  static Future<void> deleteProfile() async {
    Uri url = Uri.https(
        ApiConstants.baseUrl, ApiEndPoints.profileEndPoint);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");

      var response = await http.delete(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },);

      if (response.statusCode == 200) {
        await SharedPreferencesAll.clearToken();
      } else {
        throw Exception('Failed to delete profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete profile: $e');
    }
  }

}




