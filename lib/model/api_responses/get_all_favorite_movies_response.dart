// /// message : "favourites fetched successfully"
// /// data : []
//
// class GetAllFavoriteMoviesResponse {
//   GetAllFavoriteMoviesResponse({this.message, this.data});
//
//   GetAllFavoriteMoviesResponse.fromJson(dynamic json) {
//     message = json['message'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(GetAllFavoriteMoviesResponse.fromJson(v));
//       });
//     }
//   }
//
//   String? message;
//   List<dynamic>? data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
class GetAllFavoriteMoviesResponse {
  String? message;
  List<Map<String, dynamic>>? data; // كل عنصر Map يمثل فيلم

  GetAllFavoriteMoviesResponse({this.message, this.data});

  GetAllFavoriteMoviesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = List<Map<String, dynamic>>.from(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }
}
