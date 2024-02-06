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
    this.anonymous,
    this.password,
    this.name,
    this.professionalId,
    this.profileImageUrl,
  });

  int? id;
  String? age;
  String? deviceType;
  String? fcmToken;
  bool? anonymous;
  String? gender;
  String? mobileNo;
  String? password;
  String? name;
  int? professionalId;
  String? profileImageUrl;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        age: json["age"],
        deviceType: json["deviceType"],
        password: json["password"],
        anonymous: json["anonymous"],
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
        "deviceType": deviceType,
        "anonymous": anonymous,
        "fcmToken": fcmToken,
        "password": password,
        "gender": gender,
        "mobileNo": mobileNo,
        "name": name,
        "professionalId": professionalId,
        "profileImageUrl": profileImageUrl,
      };
}
