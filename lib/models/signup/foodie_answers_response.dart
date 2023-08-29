import 'dart:convert';

FoodieAnswersResponse foodieAnswersResponseFromJson(String str) =>
    FoodieAnswersResponse.fromJson(json.decode(str));

String foodieAnswersResponseToJson(FoodieAnswersResponse data) => json.encode(data.toJson());

class FoodieAnswersResponse {
  int? code;
  String? error;
  String? message;
  List<T>? t;
  int? userId;

  FoodieAnswersResponse(
      {this.code, this.error, this.message, this.t, this.userId});

  FoodieAnswersResponse.fromJson(Map<String, dynamic> json) {
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
  List<Answer>? answer;
  int? foodieId;
  String? inputAnswer;
  int? questionId;
  String? questionLabel;
  String? questionName;

  T(
      {this.answer,
        this.foodieId,
        this.inputAnswer,
        this.questionId,
        this.questionLabel,
        this.questionName});

  T.fromJson(Map<String, dynamic> json) {
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
    foodieId = json['foodieId'];
    inputAnswer = json['inputAnswer'];
    questionId = json['questionId'];
    questionLabel = json['questionLabel'];
    questionName = json['questionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    data['foodieId'] = this.foodieId;
    data['inputAnswer'] = this.inputAnswer;
    data['questionId'] = this.questionId;
    data['questionLabel'] = this.questionLabel;
    data['questionName'] = this.questionName;
    return data;
  }
}

class Answer {
  String? description;
  String? iconPath;
  int? id;
  String? name;
  int? questionId;
  String? status;

  Answer(
      {this.description,
        this.iconPath,
        this.id,
        this.name,
        this.questionId,
        this.status});

  Answer.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    iconPath = json['iconPath'];
    id = json['id'];
    name = json['name'];
    questionId = json['questionId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['iconPath'] = this.iconPath;
    data['id'] = this.id;
    data['name'] = this.name;
    data['questionId'] = this.questionId;
    data['status'] = this.status;
    return data;
  }
}
