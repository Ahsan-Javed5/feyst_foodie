class RatingRequest {
  T? t;

  RatingRequest({this.t});

  // RatingRequest.fromJson(Map<String, dynamic> json) {
  //   t = json['t'] != null ? T.fromJson(json['t']) : null;
  //
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (t != null) {
  //     data['t'] = t!.toJson();
  //   }
  //   return data;
  // }

  factory RatingRequest.fromJson(Map<String, dynamic> json) => RatingRequest(
    t: T.fromJson(json["t"]),
  );

  Map<String, dynamic> toJson() => {
    "t": t?.toJson(),
  };


}



class T {
  int? bookingId;
  String? comments;
  int? experienceId;
  int? foodieId;
  String? stars;

  T(
      {this.bookingId,
        this.comments,
        this.experienceId,
        this.foodieId,
        this.stars});

  T.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    comments = json['comments'];
    experienceId = json['experienceId'];
    foodieId = json['foodieId'];
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['comments'] = this.comments;
    data['experienceId'] = this.experienceId;
    data['foodieId'] = this.foodieId;
    data['stars'] = this.stars;
    return data;
  }
}