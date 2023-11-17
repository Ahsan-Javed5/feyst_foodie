import 'dart:convert';

BookingUpdateRequest bookingUpdateRequestFromJson(String str) =>
    BookingUpdateRequest.fromJson(json.decode(str));

String bookingUpdateRequestToJson(BookingUpdateRequest data) =>
    json.encode(data.toJson());

class BookingUpdateRequest {
  BookingUpdateRequest({
    required this.t,
  });

  int t;

  factory BookingUpdateRequest.fromJson(Map<String, dynamic> json) =>
      BookingUpdateRequest(
        t: json["t"],
      );

  Map<String, dynamic> toJson() => {
    "t": t,
  };
}
