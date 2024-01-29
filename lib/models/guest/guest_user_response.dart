import 'dart:convert';
// import 'package:chef/models/general_model.dart';

GuestUserResponse guestUserResponseFromJson(String str) =>
    GuestUserResponse.fromJson(json.decode(str));

String guestUserResponseToJson(GuestUserResponse data) =>
    json.encode(data.toJson());

class GuestUserResponse {
  int? code;
  String? error;
  String? message;
  T? t;
  int? userId;

  GuestUserResponse({this.code, this.error, this.message, this.t, this.userId});

  GuestUserResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['error'] = error;
    data['message'] = message;
    if (t != null) {
      data['t'] = t!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class T {
  String? age;
  bool? anonymous;
  String? authToken;
  int? averageRating;
  String? dateCreated;
  String? deviceType;
  String? fcmToken;
  List<FoodieQuestionAnswers>? foodieQuestionAnswers;
  String? gender;
  int? id;
  String? lastUpdated;
  String? mobileNo;
  String? name;
  int? noOfRatings;
  int? professionalId;
  String? profileImageUrl;
  String? status;

  T(
      {this.age,
      this.anonymous,
      this.authToken,
      this.averageRating,
      this.dateCreated,
      this.deviceType,
      this.fcmToken,
      this.foodieQuestionAnswers,
      this.gender,
      this.id,
      this.lastUpdated,
      this.mobileNo,
      this.name,
      this.noOfRatings,
      this.professionalId,
      this.profileImageUrl,
      this.status});

  T.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    anonymous = json['anonymous'];
    authToken = json['authToken'];
    averageRating = json['averageRating'];
    dateCreated = json['dateCreated'];
    deviceType = json['deviceType'];
    fcmToken = json['fcmToken'];
    if (json['foodieQuestionAnswers'] != null) {
      foodieQuestionAnswers = <FoodieQuestionAnswers>[];
      json['foodieQuestionAnswers'].forEach((v) {
        foodieQuestionAnswers!.add(FoodieQuestionAnswers.fromJson(v));
      });
    }
    gender = json['gender'];
    id = json['id'];
    lastUpdated = json['lastUpdated'];
    mobileNo = json['mobileNo'];
    name = json['name'];
    noOfRatings = json['noOfRatings'];
    professionalId = json['professionalId'];
    profileImageUrl = json['profileImageUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['authToken'] = authToken;
    data['anonymous'] = anonymous;
    data['averageRating'] = averageRating;
    data['dateCreated'] = dateCreated;
    data['deviceType'] = deviceType;
    data['fcmToken'] = fcmToken;
    if (foodieQuestionAnswers != null) {
      data['foodieQuestionAnswers'] =
          foodieQuestionAnswers!.map((v) => v.toJson()).toList();
    }
    data['gender'] = gender;
    data['id'] = id;
    data['lastUpdated'] = lastUpdated;
    data['mobileNo'] = mobileNo;
    data['name'] = name;
    data['noOfRatings'] = noOfRatings;
    data['professionalId'] = professionalId;
    data['profileImageUrl'] = profileImageUrl;
    data['status'] = status;
    return data;
  }
}

class FoodieQuestionAnswers {
  List<Answer>? answer;
  int? foodieId;
  String? inputAnswer;
  int? questionId;
  String? questionLabel;
  String? questionName;

  FoodieQuestionAnswers(
      {this.answer,
      this.foodieId,
      this.inputAnswer,
      this.questionId,
      this.questionLabel,
      this.questionName});

  FoodieQuestionAnswers.fromJson(Map<String, dynamic> json) {
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(Answer.fromJson(v));
      });
    }
    foodieId = json['foodieId'];
    inputAnswer = json['inputAnswer'];
    questionId = json['questionId'];
    questionLabel = json['questionLabel'];
    questionName = json['questionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answer != null) {
      data['answer'] = answer!.map((v) => v.toJson()).toList();
    }
    data['foodieId'] = foodieId;
    data['inputAnswer'] = inputAnswer;
    data['questionId'] = questionId;
    data['questionLabel'] = questionLabel;
    data['questionName'] = questionName;
    return data;
  }
}

class Answer {
  String? dateCreated;
  String? description;
  String? iconPath;
  int? id;
  String? lastUpdated;
  String? name;
  int? questionId;
  String? status;

  Answer(
      {this.dateCreated,
      this.description,
      this.iconPath,
      this.id,
      this.lastUpdated,
      this.name,
      this.questionId,
      this.status});

  Answer.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    description = json['description'];
    iconPath = json['iconPath'];
    id = json['id'];
    lastUpdated = json['lastUpdated'];
    name = json['name'];
    questionId = json['questionId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateCreated'] = dateCreated;
    data['description'] = description;
    data['iconPath'] = iconPath;
    data['id'] = id;
    data['lastUpdated'] = lastUpdated;
    data['name'] = name;
    data['questionId'] = questionId;
    data['status'] = status;
    return data;
  }
}
