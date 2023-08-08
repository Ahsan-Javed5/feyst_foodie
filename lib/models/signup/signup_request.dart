
class SignupRequest {
  SignupRequest({
    required this.t,
  });

  T t;

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
        t: T.fromJson(json["t"]),
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
      };
}

class T {
  T({
    this.id,
    this.age,
    this.deviceType,
    this.fcmToken,
    this.gender,
    this.mobileNo,
    this.name,
    this.professionalId,
    this.profileImageUrl,
  });

  int? id;
  String? age;
  String? deviceType;
  String? fcmToken;
  String? gender;
  String? mobileNo;
  String? name;
  int? professionalId;
  String? profileImageUrl;

  factory T.fromJson(Map<String, dynamic> json) => T(
    id: json["id"],
    age: json["age"],
    deviceType: json["deviceType"],
    fcmToken: json["fcmToken"],
    gender: json["gender"],
    mobileNo: json["mobileNo"],
    name: json["name"],
    professionalId: json["professionalId"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": age,
    "deviceType" : deviceType,
    "fcmToken" : fcmToken,
    "gender": gender,
    "mobileNo": mobileNo,
    "name": name,
    "professionalId": professionalId,
    "profileImageUrl": profileImageUrl,
  };
}
