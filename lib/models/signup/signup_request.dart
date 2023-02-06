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
    this.age,
    this.gender,
    required this.mobileNo,
    this.name,
    this.professionalId,
    this.profileImageUrl,
  });

  String? age;
  String? gender;
  String mobileNo;
  String? name;
  int? professionalId;
  String? profileImageUrl;

  factory T.fromJson(Map<String, dynamic> json) => T(
        age: json["age"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        name: json["name"],
        professionalId: json["professionalId"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "gender": gender,
        "mobileNo": mobileNo,
        "name": name,
        "professionalId": professionalId,
        "profileImageUrl": profileImageUrl,
      };
}
