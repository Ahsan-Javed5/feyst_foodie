// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    required this.code,
    required this.error,
    required this.message,
    required this.t,
    required this.userId,
  });

  int code;
  String error;
  String message;
  T t;
  int userId;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    code: json["code"],
    error: json["error"],
    message: json["message"],
    t: T.fromJson(json["t"]),
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "error": error,
    "message": message,
    "t": t.toJson(),
    "userId": userId,
  };
}

class T {
  T({
    required this.description,
    required this.experienceId,
    required this.id,
    required this.pictureUrl,
    required this.price,
    required this.scheduleId,
  });

  String description;
  int experienceId;
  int id;
  String pictureUrl;
  int price;
  int scheduleId;

  factory T.fromJson(Map<String, dynamic> json) => T(
    description: json["description"],
    experienceId: json["experienceId"],
    id: json["id"],
    pictureUrl: json["pictureUrl"],
    price: json["price"],
    scheduleId: json["scheduleId"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "experienceId": experienceId,
    "id": id,
    "pictureUrl": pictureUrl,
    "price": price,
    "scheduleId": scheduleId,
  };
}
