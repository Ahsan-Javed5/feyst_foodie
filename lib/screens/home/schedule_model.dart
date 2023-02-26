// // To parse this JSON data, do
// //
// //     final scheduleModel = scheduleModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));
//
// String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());
//
// class ScheduleModel {
//   ScheduleModel({
//     required this.code,
//    required this.error,
//     required this.message,
//     required this.t,
//     required this.userId,
//   });
//
//   int code;
//   String error;
//   String message;
//   T t;
//   int userId;
//
//   factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
//     code: json["code"],
//     error: json["error"],
//     message: json["message"],
//     t: T.fromJson(json["t"]),
//     userId: json["userId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "code": code,
//    // "error": error,
//     "message": message,
//     "t": t.toJson(),
//     "userId": userId,
//   };
// }
//
// class T {
//   T({
//     required this.chefId,
//     required this.daysGroups,
//     required this.experienceId,
//   });
//
//   int chefId;
//   List<DaysGroup> daysGroups;
//   int experienceId;
//
//   factory T.fromJson(Map<String, dynamic> json) => T(
//     chefId: json["chefId"],
//     daysGroups: List<DaysGroup>.from(json["daysGroups"].map((x) => DaysGroup.fromJson(x))),
//     experienceId: json["experienceId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "chefId": chefId,
//     "daysGroups": List<dynamic>.from(daysGroups.map((x) => x.toJson())),
//     "experienceId": experienceId,
//   };
// }
//
// class DaysGroup {
//   DaysGroup({
//     required this.dayOfMonth,
//     required this.hours,
//     required this.scheduledDate,
//   });
//
//   int dayOfMonth;
//   List<Hour> hours;
//   DateTime scheduledDate;
//
//   factory DaysGroup.fromJson(Map<String, dynamic> json) => DaysGroup(
//     dayOfMonth: json["dayOfMonth"],
//     hours: List<Hour>.from(json["hours"].map((x) => Hour.fromJson(x))),
//     scheduledDate: DateTime.parse(json["scheduledDate"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "dayOfMonth": dayOfMonth,
//     "hours": List<dynamic>.from(hours.map((x) => x.toJson())),
//     "scheduledDate": "${scheduledDate.year.toString().padLeft(4, '0')}-${scheduledDate.month.toString().padLeft(2, '0')}-${scheduledDate.day.toString().padLeft(2, '0')}",
//   };
// }
//
// class Hour {
//   Hour({
//     required this.endTime,
//     required this.hourOfDay,
//     required this.id,
//     required this.reservedStatus,
//     required this.scheduleId,
//     required this.startTime,
//   });
//
//   Time endTime;
//   int hourOfDay;
//   int id;
//   String reservedStatus;
//   int scheduleId;
//   Time startTime;
//
//   factory Hour.fromJson(Map<String, dynamic> json) => Hour(
//     endTime: Time.fromJson(json["endTime"]),
//     hourOfDay: json["hourOfDay"],
//     id: json["id"],
//     reservedStatus: json["reservedStatus"],
//     scheduleId: json["scheduleId"],
//     startTime: Time.fromJson(json["startTime"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "endTime": endTime.toJson(),
//     "hourOfDay": hourOfDay,
//     "id": id,
//     "reservedStatus": reservedStatus,
//     "scheduleId": scheduleId,
//     "startTime": startTime.toJson(),
//   };
// }
//
// class Time {
//   Time({
//     required this.hour,
//     required this.minute,
//     required this.nano,
//     required this.second,
//   });
//
//   int hour;
//   int minute;
//   int nano;
//   int second;
//
//   factory Time.fromJson(Map<String, dynamic> json) => Time(
//     hour: json["hour"],
//     minute: json["minute"],
//     nano: json["nano"],
//     second: json["second"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "hour": hour,
//     "minute": minute,
//     "nano": nano,
//     "second": second,
//   };
// }


///
///
// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    required this.t,
    this.userId,
    this.message,
    this.error,
    required this.code,
  });

  T t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int code;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
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
    this.experienceId,
    this.chefId,
    this.daysGroups,
  });

  dynamic experienceId;
  dynamic chefId;
  dynamic daysGroups;

  factory T.fromJson(Map<String, dynamic> json) => T(
    experienceId: json["experienceId"],
    chefId: json["chefId"],
    daysGroups: json["daysGroups"],
  );

  Map<String, dynamic> toJson() => {
    "experienceId": experienceId,
    "chefId": chefId,
    "daysGroups": daysGroups,
  };
}
