class LoginRequest {
  LoginRequest({
    required this.t,
  });

  T t;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        t: T.fromJson(json["t"]),
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
      };
}

class T {
  T({
    required this.mobileNo,
  });
  String mobileNo;

  factory T.fromJson(Map<String, dynamic> json) => T(
        mobileNo: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "mobileNumber": mobileNo,
      };
}
