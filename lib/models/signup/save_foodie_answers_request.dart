import 'dart:convert';

SaveFoodieRequest saveFoodieRequestFromJson(String str) => SaveFoodieRequest.fromJson(json.decode(str));

String saveFoodieRequestToJson(SaveFoodieRequest data) => json.encode(data.toJson());


class SaveFoodieRequest {
  T? t;
  int? userId;

  SaveFoodieRequest({this.t, this.userId});

  SaveFoodieRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (t != null) {
      data['t'] = t!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class T {
  List<FoodieQuestionAnswers>? foodieQuestionAnswers;

  T({this.foodieQuestionAnswers,});

  T.fromJson(Map<String, dynamic> json) {
    if (json['foodieQuestionAnswers'] != null) {
      foodieQuestionAnswers = <FoodieQuestionAnswers>[];
      json['foodieQuestionAnswers'].forEach((v) {
        foodieQuestionAnswers!.add(FoodieQuestionAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foodieQuestionAnswers != null) {
      data['foodieQuestionAnswers'] =
          foodieQuestionAnswers!.map((v) => v.toJson()).toList();
    }
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