import 'dart:convert';

BookingListRequest bookingListRequestFromJson(String str) =>
    BookingListRequest.fromJson(json.decode(str));

String bookingListRequestToJson(BookingListRequest data) =>
    json.encode(data.toJson());



class BookingListRequest {
  int? t;

  BookingListRequest({this.t});

  BookingListRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['t'] = this.t;
    return data;
  }
}