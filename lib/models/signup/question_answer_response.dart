import 'dart:convert';

FoodieQuestionAnswerResponse foodieQuestionAnswerResponseFromJson(String str) =>
    FoodieQuestionAnswerResponse.fromJson(json.decode(str));

String foodieQuestionAnswerResponseToJson(FoodieQuestionAnswerResponse data) => json.encode(data.toJson());

class FoodieQuestionAnswerResponse {
  int? code;
  String? error;
  String? message;
  List<T>? t;
  int? userId;

  FoodieQuestionAnswerResponse({this.code, this.error, this.message, this.t, this.userId});

  FoodieQuestionAnswerResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['t'] != null) {
      t = <T>[];
      json['t'].forEach((v) {
        t!.add(T.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['error'] = error;
    data['message'] = message;
    if (t != null) {
      data['t'] = t!.map((v) => v.toJson()).toList();
    }
    data['userId'] = userId;
    return data;
  }
}

class T {
  List<int>? answerIds;
  int? foodieId;
  int? id;
  String? inputAnswer;
  int? questionId;

  T({this.answerIds, this.foodieId, this.id, this.inputAnswer, this.questionId});

  T.fromJson(Map<String, dynamic> json) {
    answerIds = json['answerIds'] != null ? List<int>.from(json['answerIds']) : null;
    foodieId = json['foodieId'];
    id = json['id'];
    inputAnswer = json['inputAnswer'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answerIds'] = answerIds;
    data['foodieId'] = foodieId;
    data['id'] = id;
    data['inputAnswer'] = inputAnswer;
    data['questionId'] = questionId;
    return data;
  }
}
