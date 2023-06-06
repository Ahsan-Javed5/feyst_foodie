

import 'dart:convert';

SignUpQuestionsRequest signUpQuestionsRequestFromJson(String str) =>
    SignUpQuestionsRequest.fromJson(json.decode(str));

String signUpQuestionsRequestToJson(SignUpQuestionsRequest data) =>
    json.encode(data.toJson());



class SignUpQuestionsRequest {
  T? t;

  SignUpQuestionsRequest({this.t});

  SignUpQuestionsRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? new T.fromJson(json['t']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    return data;
  }
}

class T {
  int? userId;
  String? category;

  T({this.userId, this.category});

  T.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['category'] = this.category;
    return data;
  }
}