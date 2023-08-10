import 'dart:convert';

ReviewResponse reviewResponseFromJson(String str) =>
    ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());


class ReviewResponse {
  int? code;
  String? error;
  String? message;
  List<T>? t;
  int? userId;

  ReviewResponse({this.code, this.error, this.message, this.t, this.userId});

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['t'] != null) {
      t = <T>[];
      json['t'].forEach((v) {
        t!.add(new T.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.t != null) {
      data['t'] = this.t!.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class T {
  int? bookingId;
  String? chefBrandName;
  String? comments;
  int? experienceId;
  String? experienceImage;
  String? experienceTitle;
  int? foodieId;
  int? id;
  String? stars;
  String? status;

  T(
      {this.bookingId,
        this.chefBrandName,
        this.comments,
        this.experienceId,
        this.experienceImage,
        this.experienceTitle,
        this.foodieId,
        this.id,
        this.stars,
        this.status});

  T.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    chefBrandName = json['chefBrandName'];
    comments = json['comments'];
    experienceId = json['experienceId'];
    experienceImage = json['experienceImage'];
    experienceTitle = json['experienceTitle'];
    foodieId = json['foodieId'];
    id = json['id'];
    stars = json['stars'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['chefBrandName'] = this.chefBrandName;
    data['comments'] = this.comments;
    data['experienceId'] = this.experienceId;
    data['experienceImage'] = this.experienceImage;
    data['experienceTitle'] = this.experienceTitle;
    data['foodieId'] = this.foodieId;
    data['id'] = this.id;
    data['stars'] = this.stars;
    data['status'] = this.status;
    return data;
  }
}
