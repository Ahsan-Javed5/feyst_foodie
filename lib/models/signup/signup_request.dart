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
    required this.age,
    required this.gender,
    this.id,
    required this.mobileNo,
    required this.name,
    required this.professionalId,
    required this.profileImageUrl,
  });

  String age;
  String gender;
  int? id;
  String mobileNo;
  String name;
  int professionalId;
  String profileImageUrl;

  factory T.fromJson(Map<String, dynamic> json) => T(
        age: json["age"],
        gender: json["gender"],
        id: json["id"],
        mobileNo: json["mobileNo"],
        name: json["name"],
        professionalId: json["professionalId"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "gender": gender,
        "id": id,
        "mobileNo": mobileNo,
        "name": name,
        "professionalId": professionalId,
        "profileImageUrl": profileImageUrl,
      };
}
