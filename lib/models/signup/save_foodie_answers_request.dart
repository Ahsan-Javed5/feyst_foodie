import 'dart:convert';

SaveFoodieRequest saveFoodieRequestFromJson(String str) => SaveFoodieRequest.fromJson(json.decode(str));

String saveFoodieRequestToJson(SaveFoodieRequest data) => json.encode(data.toJson());


class SaveFoodieRequest {
  List<T1>? t;
  int? userId;

  SaveFoodieRequest({this.t, this.userId});

  SaveFoodieRequest.fromJson(Map<String, dynamic> json) {
    if (json['t'] != null) {
      t = <T1>[];
      json['t'].forEach((v) {
        t!.add(new T1.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.t != null) {
      data['t'] = this.t!.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class T1 {
  List<int>? answerIds;
  int? foodieId;
  int? id;
  String? inputAnswer;
  int? questionId;

  T1(
      {this.answerIds,
        this.foodieId,
        this.id,
        this.inputAnswer,
        this.questionId});

  T1.fromJson(Map<String, dynamic> json) {
    answerIds = json['answerIds'].cast<int>();
    foodieId = json['foodieId'];
    id = json['id'];
    inputAnswer = json['inputAnswer'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerIds'] = this.answerIds;
    data['foodieId'] = this.foodieId;
    data['id'] = this.id;
    data['inputAnswer'] = this.inputAnswer;
    data['questionId'] = this.questionId;
    return data;
  }
}

class FoodieQuestionAnswers {
  List<int>? answerIds;
  int? foodieId;
  int? id;
  String? inputAnswer;
  int? questionId;

  FoodieQuestionAnswers(
      {this.answerIds,
        this.foodieId,
        this.id,
        this.inputAnswer,
        this.questionId});

  FoodieQuestionAnswers.fromJson(Map<String, dynamic> json) {
    answerIds = json['answerIds'].cast<int>();
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