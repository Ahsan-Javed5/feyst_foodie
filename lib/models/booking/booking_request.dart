import 'dart:convert';

BookingRequest bookingRequestFromJson(String str) =>
    BookingRequest.fromJson(json.decode(str));

String bookingRequestToJson(BookingRequest data) => json.encode(data.toJson());

class BookingRequest {
  BookingRequest({
    required this.t,
  });

  T t;

  factory BookingRequest.fromJson(Map<String, dynamic> json) => BookingRequest(
        t: T.fromJson(json["t"]),
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
      };
}

class T {
  T({
    required this.comments,
    required this.experienceId,
    required this.foodieId,
    required this.totalPrice,
    required this.scheduleId,
  });

  String comments;
  int experienceId;
  int foodieId;
  int totalPrice;
  int scheduleId;

  factory T.fromJson(Map<String, dynamic> json) => T(
        comments: json["comments"],
        experienceId: json["experienceId"],
        foodieId: json["foodieId"],
        totalPrice: json["totalPrice"],
        scheduleId: json["scheduleId"],
      );

  Map<String, dynamic> toJson() => {
        "comments": comments,
        "experienceId": experienceId,
        "foodieId": foodieId,
        "totalPrice": totalPrice,
        "scheduleId": scheduleId,
      };
}
