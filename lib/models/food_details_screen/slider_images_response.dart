

import 'dart:convert';

SliderImagesResponse sliderImagesFromJson(String str) =>
    SliderImagesResponse.fromJson(json.decode(str));

String sliderImagesToJson(SliderImagesResponse data) => json.encode(data.toJson());



class SliderImagesResponse {
  int? code;
  String? error;
  String? message;
  List<T>? t;
  int? userId;

  SliderImagesResponse(
      {this.code, this.error, this.message, this.t, this.userId});

  SliderImagesResponse.fromJson(Map<String, dynamic> json) {
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
  int? experienceId;
  int? id;
  String? mediaUrl;
  String? type;

  T({this.experienceId, this.id, this.mediaUrl, this.type});

  T.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    id = json['id'];
    mediaUrl = json['mediaUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experienceId'] = this.experienceId;
    data['id'] = this.id;
    data['mediaUrl'] = this.mediaUrl;
    data['type'] = this.type;
    return data;
  }
}