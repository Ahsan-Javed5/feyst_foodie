import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) =>
    BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) =>
    json.encode(data.toJson());

class BookingResponse {
  BookingResponse({
    required this.t,
    this.userId,
    required this.message,
    this.error,
    required this.code,
  });

  T t;
  dynamic userId;
  String message;
  dynamic error;
  int code;

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        t: T.fromJson(json["t"]),
        userId: json["userId"],
        message: json["message"],
        error: json["error"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
        "userId": userId,
        "message": message,
        "error": error,
        "code": code,
      };
}

class T {
  T({
    required this.id,
    required this.experienceId,
    required this.foodieId,
    required this.comments,
    required this.totalPrice,
  });

  int id;
  int experienceId;
  int foodieId;
  String comments;
  int totalPrice;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        experienceId: json["experienceId"],
        foodieId: json["foodieId"],
        comments: json["comments"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "experienceId": experienceId,
        "foodieId": foodieId,
        "comments": comments,
        "totalPrice": totalPrice,
      };
}
