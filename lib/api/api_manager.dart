import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieapproute/api/api_constants.dart';
import 'package:movieapproute/api/api_endpoints.dart';
import 'package:movieapproute/model/api_responses/register_response.dart';

import '../model/api_responses/movie_response.dart';

class ApiManager {
  static Future<RegisterResponse> postRegisterData(
    String name,
    String email,
    String password,
    String confirmPassword,
    String phone,
    int avatarId,
  ) async {
    //todo: register api:  https://  route-movie-apis.vercel.app  /auth/register

    Uri url = Uri.https(
      ApiConstants.registerBaseUrl,
      ApiEndPoints.registerEndPoint,
    );
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

}
