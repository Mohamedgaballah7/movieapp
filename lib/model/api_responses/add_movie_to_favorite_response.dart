/// message : "Added to favourite successfully"
/// data : {"movieId":"movieId","name":"test","rating":2.4,"imageURL":"https//imagelink","year":"2002"}

class AddMovieToFavoriteResponse {
  AddMovieToFavoriteResponse({this.message, this.data});

  AddMovieToFavoriteResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// movieId : "movieId"
/// name : "test"
/// rating : 2.4
/// imageURL : "https//imagelink"
/// year : "2002"

class Data {
  Data({this.movieId, this.name, this.rating, this.imageURL, this.year});

  Data.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }

  String? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }
}
