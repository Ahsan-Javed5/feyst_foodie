import 'dart:convert';

ExperienceListResponse experienceListResponseFromJson(String str) =>
    ExperienceListResponse.fromJson(json.decode(str));

String experienceListResponseToJson(ExperienceListResponse data) =>
    json.encode(data.toJson());

class ExperienceListResponse {
  ExperienceListResponse({
    required this.t,
    this.userId,
    this.message,
    this.error,
    required this.code,
  });

  List<T> t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int code;

  factory ExperienceListResponse.fromJson(Map<String, dynamic> json) =>
      ExperienceListResponse(
        t: List<T>.from(json["t"].map((x) => T.fromJson(x))),
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

class T {
  T({
    required this.id,
    required this.title,
    required this.description,
    required this.wowFactorId,
    required this.preferenceId,
    required this.price,
    required this.priceTypeId,
    required this.persons,
    required this.locationId,
    required this.subHostName,
    required this.subHostMobileNo,
    required this.experienceWowFactors,
    required this.experiencePreferences,
  });

  int id;
  String title;
  String description;
  int wowFactorId;
  int preferenceId;
  int price;
  int priceTypeId;
  String persons;
  int locationId;
  String subHostName;
  String subHostMobileNo;
  List<ExperienceWowFactor> experienceWowFactors;
  List<ExperiencePreference> experiencePreferences;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        wowFactorId: json["wowFactorId"],
        preferenceId: json["preferenceId"],
        price: json["price"],
        priceTypeId: json["priceTypeId"],
        persons: json["persons"],
        locationId: json["locationId"],
        subHostName: json["subHostName"],
        subHostMobileNo: json["subHostMobileNo"],
        experienceWowFactors: List<ExperienceWowFactor>.from(
            json["experienceWowFactors"]
                .map((x) => ExperienceWowFactor.fromJson(x))),
        experiencePreferences: List<ExperiencePreference>.from(
            json["experiencePreferences"]
                .map((x) => ExperiencePreference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "wowFactorId": wowFactorId,
        "preferenceId": preferenceId,
        "price": price,
        "priceTypeId": priceTypeId,
        "persons": persons,
        "locationId": locationId,
        "subHostName": subHostName,
        "subHostMobileNo": subHostMobileNo,
        "experienceWowFactors":
            List<dynamic>.from(experienceWowFactors.map((x) => x.toJson())),
        "experiencePreferences":
            List<dynamic>.from(experiencePreferences.map((x) => x.toJson())),
      };
}

class ExperiencePreference {
  ExperiencePreference({
    required this.id,
    required this.experienceId,
    required this.preferenceId,
  });

  int id;
  int experienceId;
  int preferenceId;

  factory ExperiencePreference.fromJson(Map<String, dynamic> json) =>
      ExperiencePreference(
        id: json["id"],
        experienceId: json["experienceId"],
        preferenceId: json["preferenceId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "experienceId": experienceId,
        "preferenceId": preferenceId,
      };
}

class ExperienceWowFactor {
  ExperienceWowFactor({
    required this.id,
    required this.experienceId,
    required this.wowFactorId,
  });

  int id;
  int experienceId;
  int wowFactorId;

  factory ExperienceWowFactor.fromJson(Map<String, dynamic> json) =>
      ExperienceWowFactor(
        id: json["id"],
        experienceId: json["experienceId"],
        wowFactorId: json["wowFactorId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "experienceId": experienceId,
        "wowFactorId": wowFactorId,
      };
}
