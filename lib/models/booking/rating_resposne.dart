
import 'dart:convert';

RatingResponse ratingResponseFromJson(String str) =>
    RatingResponse.fromJson(json.decode(str));

String ratingResponseToJson(RatingResponse data) => json.encode(data.toJson());


class RatingResponse {
  int? code;
  String? error;
  String? message;
  T? t;
  int? userId;

  RatingResponse({this.code, this.error, this.message, this.t, this.userId});

  RatingResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    t = json['t'] != null ? new T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class T {
  int? bookingId;
  String? comments;
  int? experienceId;
  int? foodieId;
  int? id;
  String? stars;

  T(
      {this.bookingId,
        this.comments,
        this.experienceId,
        this.foodieId,
        this.id,
        this.stars});

  T.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    comments = json['comments'];
    experienceId = json['experienceId'];
    foodieId = json['foodieId'];
    id = json['id'];
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['comments'] = this.comments;
    data['experienceId'] = this.experienceId;
    data['foodieId'] = this.foodieId;
    data['id'] = this.id;
    data['stars'] = this.stars;
    return data;
  }
}
