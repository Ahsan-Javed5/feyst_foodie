class HomeResponse {
  int? code;
  String? error;
  String? message;
  T? t;
  int? userId;

  HomeResponse({this.code, this.error, this.message, this.t, this.userId});

  HomeResponse.fromJson(Map<String, dynamic> json) {
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
  List<Experiences>? allExperience;
  List<Experiences>? popularExperiences;

  T({this.allExperience, this.popularExperiences});

  T.fromJson(Map<String, dynamic> json) {
    if (json['allExperience'] != null) {
      allExperience = <Experiences>[];
      json['allExperience'].forEach((v) {
        allExperience!.add(Experiences.fromJson(v));
      });
    }
    if (json['popularExperiences'] != null) {
      popularExperiences = <Experiences>[];
      json['popularExperiences'].forEach((v) {
        popularExperiences!.add(Experiences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allExperience != null) {
      data['allExperience'] =
          this.allExperience!.map((v) => v.toJson()).toList();
    }
    if (this.popularExperiences != null) {
      data['popularExperiences'] =
          this.popularExperiences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Experiences {
  String? chefAddress;
  String? chefBrandName;
  int? chefId;
  String? chefName;
  int? cityId;
  String? cityName;
  String? description;
  List<ExperienceMedia>? experienceMedia;
  List<ExperiencePreferences>? experiencePreferences;
  List<ExperienceWowFactors>? experienceWowFactors;
  int? id;
  int? latitude;
  int? locationId;
  int? longitude;
  int? personMaxLimit;
  String? persons;
  String? placeId;
  int? preferenceId;
  int? price;
  int? priceTypeId;
  String? subHostMobileNo;
  String? subHostName;
  String? title;
  int? townId;
  String? townName;
  int? wowFactorId;

  Experiences(
      {this.chefAddress,
        this.chefBrandName,
        this.chefId,
        this.chefName,
        this.cityId,
        this.cityName,
        this.description,
        this.experienceMedia,
        this.experiencePreferences,
        this.experienceWowFactors,
        this.id,
        this.latitude,
        this.locationId,
        this.longitude,
        this.personMaxLimit,
        this.persons,
        this.placeId,
        this.preferenceId,
        this.price,
        this.priceTypeId,
        this.subHostMobileNo,
        this.subHostName,
        this.title,
        this.townId,
        this.townName,
        this.wowFactorId});

  Experiences.fromJson(Map<String, dynamic> json) {
    chefAddress = json['chefAddress'];
    chefBrandName = json['chefBrandName'];
    chefId = json['chefId'];
    chefName = json['chefName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    description = json['description'];
    if (json['experienceMedia'] != null) {
      experienceMedia = <ExperienceMedia>[];
      json['experienceMedia'].forEach((v) {
        experienceMedia!.add(new ExperienceMedia.fromJson(v));
      });
    }
    if (json['experiencePreferences'] != null) {
      experiencePreferences = <ExperiencePreferences>[];
      json['experiencePreferences'].forEach((v) {
        experiencePreferences!.add(new ExperiencePreferences.fromJson(v));
      });
    }
    if (json['experienceWowFactors'] != null) {
      experienceWowFactors = <ExperienceWowFactors>[];
      json['experienceWowFactors'].forEach((v) {
        experienceWowFactors!.add(new ExperienceWowFactors.fromJson(v));
      });
    }
    id = json['id'];
    latitude = json['latitude'];
    locationId = json['locationId'];
    longitude = json['longitude'];
    personMaxLimit = json['personMaxLimit'];
    persons = json['persons'];
    placeId = json['placeId'];
    preferenceId = json['preferenceId'];
    price = json['price'];
    priceTypeId = json['priceTypeId'];
    subHostMobileNo = json['subHostMobileNo'];
    subHostName = json['subHostName'];
    title = json['title'];
    townId = json['townId'];
    townName = json['townName'];
    wowFactorId = json['wowFactorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chefAddress'] = this.chefAddress;
    data['chefBrandName'] = this.chefBrandName;
    data['chefId'] = this.chefId;
    data['chefName'] = this.chefName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['description'] = this.description;
    if (this.experienceMedia != null) {
      data['experienceMedia'] =
          this.experienceMedia!.map((v) => v.toJson()).toList();
    }
    if (this.experiencePreferences != null) {
      data['experiencePreferences'] =
          this.experiencePreferences!.map((v) => v.toJson()).toList();
    }
    if (this.experienceWowFactors != null) {
      data['experienceWowFactors'] =
          this.experienceWowFactors!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['locationId'] = this.locationId;
    data['longitude'] = this.longitude;
    data['personMaxLimit'] = this.personMaxLimit;
    data['persons'] = this.persons;
    data['placeId'] = this.placeId;
    data['preferenceId'] = this.preferenceId;
    data['price'] = this.price;
    data['priceTypeId'] = this.priceTypeId;
    data['subHostMobileNo'] = this.subHostMobileNo;
    data['subHostName'] = this.subHostName;
    data['title'] = this.title;
    data['townId'] = this.townId;
    data['townName'] = this.townName;
    data['wowFactorId'] = this.wowFactorId;
    return data;
  }
}

class ExperienceMedia {
  int? experienceId;
  int? id;
  String? mediaUrl;
  String? type;

  ExperienceMedia({this.experienceId, this.id, this.mediaUrl, this.type});

  ExperienceMedia.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    id = json['id'];
    mediaUrl = json['mediaUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experienceId'] = this.experienceId;
    data['id'] = this.id;
    data['mediaUrl'] = this.mediaUrl;
    data['type'] = this.type;
    return data;
  }
}

class ExperiencePreferences {
  int? experienceId;
  int? id;
  String? preferenceDescription;
  String? preferenceIconPath;
  int? preferenceId;
  String? preferenceName;

  ExperiencePreferences(
      {this.experienceId,
        this.id,
        this.preferenceDescription,
        this.preferenceIconPath,
        this.preferenceId,
        this.preferenceName});

  ExperiencePreferences.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    id = json['id'];
    preferenceDescription = json['preferenceDescription'];
    preferenceIconPath = json['preferenceIconPath'];
    preferenceId = json['preferenceId'];
    preferenceName = json['preferenceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experienceId'] = this.experienceId;
    data['id'] = this.id;
    data['preferenceDescription'] = this.preferenceDescription;
    data['preferenceIconPath'] = this.preferenceIconPath;
    data['preferenceId'] = this.preferenceId;
    data['preferenceName'] = this.preferenceName;
    return data;
  }
}

class ExperienceWowFactors {
  int? experienceId;
  int? id;
  String? wowFactorDescription;
  String? wowFactorIconPath;
  int? wowFactorId;
  String? wowFactorName;

  ExperienceWowFactors(
      {this.experienceId,
        this.id,
        this.wowFactorDescription,
        this.wowFactorIconPath,
        this.wowFactorId,
        this.wowFactorName});

  ExperienceWowFactors.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    id = json['id'];
    wowFactorDescription = json['wowFactorDescription'];
    wowFactorIconPath = json['wowFactorIconPath'];
    wowFactorId = json['wowFactorId'];
    wowFactorName = json['wowFactorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experienceId'] = this.experienceId;
    data['id'] = this.id;
    data['wowFactorDescription'] = this.wowFactorDescription;
    data['wowFactorIconPath'] = this.wowFactorIconPath;
    data['wowFactorId'] = this.wowFactorId;
    data['wowFactorName'] = this.wowFactorName;
    return data;
  }
}
