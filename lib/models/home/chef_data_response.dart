

import 'dart:convert';

ChefDataResponse chefModelFromJson(String str) =>
    ChefDataResponse.fromJson(json.decode(str));

String chefModelToJson(ChefDataResponse data) => json.encode(data.toJson());

class ChefDataResponse {
  int? code;
  String? error;
  String? message;
  T? t;
  int? userId;

  ChefDataResponse({this.code, this.error, this.message, this.t, this.userId});

  ChefDataResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    t = json['t'] != null ? new T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class T {
  String? address;
  String? brandName;
  List<ChefQuestionAnswers>? chefQuestionAnswers;
  int? cityId;
  String? cityName;
  String? facebook;
  int? id;
  String? instagram;
  double? latitude;
  double? longitude;
  String? mobileNo;
  String? name;
  String? placeId;
  String? profileImageUrl;
  String? tiktok;
  int? townId;
  String? townName;
  String? twitter;

  T(
      {this.address,
        this.brandName,
        this.chefQuestionAnswers,
        this.cityId,
        this.cityName,
        this.facebook,
        this.id,
        this.instagram,
        this.latitude,
        this.longitude,
        this.mobileNo,
        this.name,
        this.placeId,
        this.profileImageUrl,
        this.tiktok,
        this.townId,
        this.townName,
        this.twitter});

  T.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    brandName = json['brandName'];
    if (json['chefQuestionAnswers'] != null) {
      chefQuestionAnswers = <ChefQuestionAnswers>[];
      json['chefQuestionAnswers'].forEach((v) {
        chefQuestionAnswers!.add(new ChefQuestionAnswers.fromJson(v));
      });
    }
    cityId = json['cityId'];
    cityName = json['cityName'];
    facebook = json['facebook'];
    id = json['id'];
    instagram = json['instagram'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mobileNo = json['mobileNo'];
    name = json['name'];
    placeId = json['placeId'];
    profileImageUrl = json['profileImageUrl'];
    tiktok = json['tiktok'];
    townId = json['townId'];
    townName = json['townName'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['brandName'] = this.brandName;
    if (this.chefQuestionAnswers != null) {
      data['chefQuestionAnswers'] =
          this.chefQuestionAnswers!.map((v) => v.toJson()).toList();
    }
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['facebook'] = this.facebook;
    data['id'] = this.id;
    data['instagram'] = this.instagram;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['mobileNo'] = this.mobileNo;
    data['name'] = this.name;
    data['placeId'] = this.placeId;
    data['profileImageUrl'] = this.profileImageUrl;
    data['tiktok'] = this.tiktok;
    data['townId'] = this.townId;
    data['townName'] = this.townName;
    data['twitter'] = this.twitter;
    return data;
  }
}

class ChefQuestionAnswers {
  List<Answers>? answers;
  int? chefId;
  String? inputAnswer;
  Question? question;

  ChefQuestionAnswers(
      {this.answers, this.chefId, this.inputAnswer, this.question});

  ChefQuestionAnswers.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    chefId = json['chefId'];
    inputAnswer = json['inputAnswer'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['chefId'] = this.chefId;
    data['inputAnswer'] = this.inputAnswer;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    return data;
  }
}

class Answers {
  String? description;
  String? iconPath;
  int? id;
  String? name;
  int? questionId;

  Answers(
      {this.description, this.iconPath, this.id, this.name, this.questionId});

  Answers.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    iconPath = json['iconPath'];
    id = json['id'];
    name = json['name'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['iconPath'] = this.iconPath;
    data['id'] = this.id;
    data['name'] = this.name;
    data['questionId'] = this.questionId;
    return data;
  }
}

class Question {
  List<Answers>? answers;
  String? category;
  String? description;
  int? id;
  String? name;
  String? type;

  Question(
      {this.answers,
        this.category,
        this.description,
        this.id,
        this.name,
        this.type});

  Question.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    category = json['category'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['description'] = this.description;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}