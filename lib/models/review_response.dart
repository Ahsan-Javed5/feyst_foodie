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
  String? chefBrandName;
  int? chefId;
  String? comments;
  String? dateCreated;
  int? experienceBookingId;
  String? experienceImage;
  String? experienceTitle;
  int? foodieId;
  String? foodieName;
  int? id;
  String? lastUpdated;
  String? stars;
  String? status;

  T(
      {this.chefBrandName,
      this.chefId,
      this.comments,
      this.dateCreated,
      this.experienceBookingId,
      this.experienceImage,
      this.experienceTitle,
      this.foodieId,
      this.foodieName,
      this.id,
      this.lastUpdated,
      this.stars,
      this.status});

  T.fromJson(Map<String, dynamic> json) {
    chefBrandName = json['chefBrandName'];
    chefId = json['chefId'];
    comments = json['comments'];
    dateCreated = json['dateCreated'];
    experienceBookingId = json['experienceBookingId'];
    experienceImage = json['experienceImage'];
    experienceTitle = json['experienceTitle'];
    foodieId = json['foodieId'];
    foodieName = json['foodieName'];
    id = json['id'];
    lastUpdated = json['lastUpdated'];
    stars = json['stars'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chefBrandName'] = this.chefBrandName;
    data['chefId'] = this.chefId;
    data['comments'] = this.comments;
    data['dateCreated'] = this.dateCreated;
    data['experienceBookingId'] = this.experienceBookingId;
    data['experienceImage'] = this.experienceImage;
    data['experienceTitle'] = this.experienceTitle;
    data['foodieId'] = this.foodieId;
    data['foodieName'] = this.foodieName;
    data['id'] = this.id;
    data['lastUpdated'] = this.lastUpdated;
    data['stars'] = this.stars;
    data['status'] = this.status;
    return data;
  }
}
