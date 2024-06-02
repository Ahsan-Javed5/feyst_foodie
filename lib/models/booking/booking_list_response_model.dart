import 'dart:convert';

BookingListModel bookingListModelFromJson(String str) =>
    BookingListModel.fromJson(json.decode(str));

String bookingListModelToJson(BookingListModel data) =>
    json.encode(data.toJson());

class BookingListModel {
  List<BookingItem>? t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int? code;

  BookingListModel({this.t, this.userId, this.message, this.error, this.code});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    if (json['t'] != null) {
      t = <BookingItem>[];
      json['t'].forEach((v) {
        t!.add(new BookingItem.fromJson(v));
      });
    }
    userId = json['userId'];
    message = json['message'];
    error = json['error'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (t != null) {
      data['t'] = t!.map((v) => v.toJson()).toList();
    }
    data['userId'] = userId;
    data['message'] = message;
    data['error'] = error;
    data['code'] = code;
    return data;
  }
}

class BookingItem {
  int? id;
  int? experienceId;
  int? foodieId;
  String? comments;
  int? totalPrice;
  int? verificationCode;
  int? priceTypeId;
  String? bookingStatus;
  int? scheduleId;
  String? scheduleScheduledDate;
  String? experienceAverageRating;
  String? scheduleStartTime;
  int? scheduleDayOfMonth;
  String? persons;
  int? preferenceId;
  String? preferenceName;
  String? preferenceDescription;
  String? preferenceIconPath;
  String? experienceName;
  String? chefProfileImageUrl;
  int? chefId;
  String? brandName;

  BookingItem(
      {this.id,
      this.experienceId,
      this.foodieId,
      this.comments,
      this.totalPrice,
      this.chefProfileImageUrl,
      this.verificationCode,
      this.priceTypeId,
      this.bookingStatus,
      this.experienceAverageRating,
      this.scheduleId,
      this.scheduleScheduledDate,
      this.scheduleStartTime,
      this.scheduleDayOfMonth,
      this.persons,
      this.preferenceId,
      this.preferenceName,
      this.preferenceDescription,
      this.preferenceIconPath,
      this.experienceName,
      this.chefId,
      this.brandName});

  BookingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    experienceId = json['experienceId'];
    foodieId = json['foodieId'];
    comments = json['comments'];
    totalPrice = json['totalPrice'];
    verificationCode = json['verificationCode'];
    priceTypeId = json['priceTypeId'];
    bookingStatus = json['bookingStatus'];
    chefProfileImageUrl = json['chefProfileImageUrl'];
    scheduleId = json['scheduleId'];
    experienceAverageRating = json['experienceAverageRating'];
    scheduleScheduledDate = json['scheduleScheduledDate'];
    scheduleStartTime = json['scheduleStartTime'];
    scheduleDayOfMonth = json['scheduleDayOfMonth'];
    persons = json['persons'];
    preferenceId = json['preferenceId'];
    preferenceName = json['preferenceName'];
    preferenceDescription = json['preferenceDescription'];
    preferenceIconPath = json['preferenceIconPath'];
    experienceName = json['experienceName'];
    chefId = json['chefId'];
    brandName = json['brandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['experienceId'] = experienceId;
    data['foodieId'] = foodieId;
    data['comments'] = comments;
    data['totalPrice'] = totalPrice;
    data['experienceAverageRating'] = experienceAverageRating;
    data['verificationCode'] = verificationCode;
    data['chefProfileImageUrl'] = chefProfileImageUrl;
    data['priceTypeId'] = priceTypeId;
    data['bookingStatus'] = bookingStatus;
    data['scheduleId'] = scheduleId;
    data['scheduleScheduledDate'] = scheduleScheduledDate;
    data['scheduleStartTime'] = scheduleStartTime;
    data['scheduleDayOfMonth'] = scheduleDayOfMonth;
    data['persons'] = persons;
    data['preferenceId'] = preferenceId;
    data['preferenceName'] = preferenceName;
    data['preferenceDescription'] = preferenceDescription;
    data['preferenceIconPath'] = preferenceIconPath;
    data['experienceName'] = experienceName;
    data['chefId'] = chefId;
    data['brandName'] = brandName;
    return data;
  }
}
