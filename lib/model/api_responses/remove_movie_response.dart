/// message : "Removed from favourite successfully"

class RemoveMovieResponse {
  RemoveMovieResponse({this.message});

  RemoveMovieResponse.fromJson(dynamic json) {
    message = json['message'];
  }

  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
