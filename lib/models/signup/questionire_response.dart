// To parse this JSON data, do
//
//     final questionireResponse = questionireResponseFromJson(jsonString);

import 'dart:convert';

QuestionireResponse questionireResponseFromJson(String str) => QuestionireResponse.fromJson(json.decode(str));

String questionireResponseToJson(QuestionireResponse data) => json.encode(data.toJson());

class QuestionireResponse {
  QuestionireResponse({
    required this.t,
    this.userId,
    this.message,
    this.error,
    required this.code,
  });

  List<QuestionsList> t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int code;

  factory QuestionireResponse.fromJson(Map<String, dynamic> json) => QuestionireResponse(
    t: List<QuestionsList>.from(json["t"].map((x) => QuestionsList.fromJson(x))),
    userId: json["userId"],
    message: json["message"],
    error: json["error"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "t": List<dynamic>.from(t.map((x) => x.toJson())),
    "userId": userId,
    "message": message,
    "error": error,
    "code": code,
  };
}

class QuestionsList {
  QuestionsList({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.category,
    required this.answers,
  });

  int id;
  String name;
  String description;
  String type;
  String category;
  List<Answer> answers;

  factory QuestionsList.fromJson(Map<String, dynamic> json) => QuestionsList(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
    category: json["category"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "type": type,
    "category": category,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    required this.id,
    required this.name,
    required this.description,
    required this.questionId,
  });

  int id;
  String name;
  String description;
  int questionId;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    questionId: json["questionId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "questionId": questionId,
  };
}
