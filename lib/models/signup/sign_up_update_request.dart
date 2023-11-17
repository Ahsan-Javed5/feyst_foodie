class SignupUpdateRequest {
  SignupUpdateRequest({
    required this.t,
  });

  T t;

  factory SignupUpdateRequest.fromJson(Map<String, dynamic> json) => SignupUpdateRequest(
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
    this.gender,
    this.name,
    this.professionalId,
  });

  int? id;
  String? age;
  String? gender;
  String? name;
  int? professionalId;

  factory T.fromJson(Map<String, dynamic> json) => T(
    id: json["id"],
    age: json["age"],
    gender: json["gender"],
    name: json["name"],
    professionalId: json["professionalId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": age,
    "gender": gender,
    "name": name,
    "professionalId": professionalId,
  };
}