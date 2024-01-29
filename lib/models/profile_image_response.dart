import 'dart:convert';

ProfileImageResponse profileImageResponseFromJson(String str) =>
    ProfileImageResponse.fromJson(json.decode(str));

String profileImageResponseToJson(ProfileImageResponse data) =>
    json.encode(data.toJson());

class ProfileImageResponse {
  int? code;
  String? error;
  String? message;
  T? t;
  int? userId;

  ProfileImageResponse(
      {this.code, this.error, this.message, this.t, this.userId});

  ProfileImageResponse.fromJson(Map<String, dynamic> json) {
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
  String? age;
  dynamic averageRating;
  String? deviceType;
  String? fcmToken;
  String? gender;
  int? id;
  String? mobileNo;
  String? name;
  int? professionalId;
  String? profileImageUrl;
  String? status;

  T(
      {this.age,
      this.averageRating,
      this.deviceType,
      this.fcmToken,
      this.gender,
      this.id,
      this.mobileNo,
      this.name,
      this.professionalId,
      this.profileImageUrl,
      this.status});

  T.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    averageRating = json['averageRating'];
    deviceType = json['deviceType'];
    fcmToken = json['fcmToken'];
    gender = json['gender'];
    id = json['id'];
    mobileNo = json['mobileNo'];
    name = json['name'];
    professionalId = json['professionalId'];
    profileImageUrl = json['profileImageUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['averageRating'] = this.averageRating;
    data['deviceType'] = this.deviceType;
    data['fcmToken'] = this.fcmToken;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['mobileNo'] = this.mobileNo;
    data['name'] = this.name;
    data['professionalId'] = this.professionalId;
    data['profileImageUrl'] = this.profileImageUrl;
    data['status'] = this.status;
    return data;
  }
}
