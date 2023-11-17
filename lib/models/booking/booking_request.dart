import 'dart:convert';

import '../../screens/home/widget/food_details_screen.dart';

BookingRequest bookingRequestFromJson(String str) =>
    BookingRequest.fromJson(json.decode(str));

String bookingRequestToJson(BookingRequest data) => json.encode(data.toJson());

class BookingRequest {
  T? t;

  BookingRequest({this.t});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? new T.fromJson(json['t']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    return data;
  }
}

class T {
  String? address;
  List<BookingDetails>? bookingDetails;
  String? bookingStatus;
  String? brandName;
  int? chefId;
  String? chefMobileNo;
  String? chefProfileImageUrl;
  bool? chefRated;
  String? cityName;
  String? comments;
  int? experienceId;
  String? experienceName;
  int? foodieId;
  String? foodieName;
  String? foodieProfileImageUrl;
  bool? foodieRated;
  int? id;
  String? persons;
  String? preferenceDescription;
  String? preferenceIconPath;
  int? preferenceId;
  String? preferenceName;
  int? priceTypeId;
  int? scheduleDayOfMonth;
  int? scheduleId;
  String? scheduleScheduledDate;
  ScheduleStartTime? scheduleStartTime;
  String? status;
  String? subHost;
  String? subHostMobileNo;
  int? totalPrice;
  String? townName;
  int? verificationCode;

  T(
      {this.address,
        this.bookingDetails,
        this.bookingStatus,
        this.brandName,
        this.chefId,
        this.chefMobileNo,
        this.chefProfileImageUrl,
        this.chefRated,
        this.cityName,
        this.comments,
        this.experienceId,
        this.experienceName,
        this.foodieId,
        this.foodieName,
        this.foodieProfileImageUrl,
        this.foodieRated,
        this.id,
        this.persons,
        this.preferenceDescription,
        this.preferenceIconPath,
        this.preferenceId,
        this.preferenceName,
        this.priceTypeId,
        this.scheduleDayOfMonth,
        this.scheduleId,
        this.scheduleScheduledDate,
        this.scheduleStartTime,
        this.status,
        this.subHost,
        this.subHostMobileNo,
        this.totalPrice,
        this.townName,
        this.verificationCode});

  T.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    if (json['bookingDetails'] != null) {
      bookingDetails = <BookingDetails>[];
      json['bookingDetails'].forEach((v) {
        bookingDetails!.add(new BookingDetails.fromJson(v));
      });
    }
    bookingStatus = json['bookingStatus'];
    brandName = json['brandName'];
    chefId = json['chefId'];
    chefMobileNo = json['chefMobileNo'];
    chefProfileImageUrl = json['chefProfileImageUrl'];
    chefRated = json['chefRated'];
    cityName = json['cityName'];
    comments = json['comments'];
    experienceId = json['experienceId'];
    experienceName = json['experienceName'];
    foodieId = json['foodieId'];
    foodieName = json['foodieName'];
    foodieProfileImageUrl = json['foodieProfileImageUrl'];
    foodieRated = json['foodieRated'];
    id = json['id'];
    persons = json['persons'];
    preferenceDescription = json['preferenceDescription'];
    preferenceIconPath = json['preferenceIconPath'];
    preferenceId = json['preferenceId'];
    preferenceName = json['preferenceName'];
    priceTypeId = json['priceTypeId'];
    scheduleDayOfMonth = json['scheduleDayOfMonth'];
    scheduleId = json['scheduleId'];
    scheduleScheduledDate = json['scheduleScheduledDate'];
    scheduleStartTime = json['scheduleStartTime'] != null
        ? new ScheduleStartTime.fromJson(json['scheduleStartTime'])
        : null;
    status = json['status'];
    subHost = json['subHost'];
    subHostMobileNo = json['subHostMobileNo'];
    totalPrice = json['totalPrice'];
    townName = json['townName'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    if (this.bookingDetails != null) {
      data['bookingDetails'] =
          this.bookingDetails!.map((v) => v.toJson()).toList();
    }
    data['bookingStatus'] = this.bookingStatus;
    data['brandName'] = this.brandName;
    data['chefId'] = this.chefId;
    data['chefMobileNo'] = this.chefMobileNo;
    data['chefProfileImageUrl'] = this.chefProfileImageUrl;
    data['chefRated'] = this.chefRated;
    data['cityName'] = this.cityName;
    data['comments'] = this.comments;
    data['experienceId'] = this.experienceId;
    data['experienceName'] = this.experienceName;
    data['foodieId'] = this.foodieId;
    data['foodieName'] = this.foodieName;
    data['foodieProfileImageUrl'] = this.foodieProfileImageUrl;
    data['foodieRated'] = this.foodieRated;
    data['id'] = this.id;
    data['persons'] = this.persons;
    data['preferenceDescription'] = this.preferenceDescription;
    data['preferenceIconPath'] = this.preferenceIconPath;
    data['preferenceId'] = this.preferenceId;
    data['preferenceName'] = this.preferenceName;
    data['priceTypeId'] = this.priceTypeId;
    data['scheduleDayOfMonth'] = this.scheduleDayOfMonth;
    data['scheduleId'] = this.scheduleId;
    data['scheduleScheduledDate'] = this.scheduleScheduledDate;
    if (this.scheduleStartTime != null) {
      data['scheduleStartTime'] = this.scheduleStartTime!.toJson();
    }
    data['status'] = this.status;
    data['subHost'] = this.subHost;
    data['subHostMobileNo'] = this.subHostMobileNo;
    data['totalPrice'] = this.totalPrice;
    data['townName'] = this.townName;
    data['verificationCode'] = this.verificationCode;
    return data;
  }
}

class BookingDetails {
  int? menuId;
  int? quantity;

  BookingDetails({this.menuId, this.quantity});

  BookingDetails.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuId'] = this.menuId;
    data['quantity'] = this.quantity;
    return data;
  }
}

class ScheduleStartTime {
  String? hour;
  String? minute;
  int? nano;
  String? second;

  ScheduleStartTime({this.hour, this.minute, this.nano, this.second});

  ScheduleStartTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
    nano = json['nano'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['nano'] = this.nano;
    data['second'] = this.second;
    return data;
  }
}

