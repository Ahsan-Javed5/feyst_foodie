class HomeResponse {
  T? t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int? code;

  HomeResponse({this.t, this.userId, this.message, this.error, this.code});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    userId = json['userId'];
    message = json['message'];
    error = json['error'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (t != null) {
      data['t'] = t!.toJson();
    }
    data['userId'] = userId;
    data['message'] = message;
    data['error'] = error;
    data['code'] = code;
    return data;
  }
}

class T {
  List<Experiences>? popularExperiences;
  List<Experiences>? allExperiences;

  T({this.popularExperiences, this.allExperiences});

  T.fromJson(Map<String, dynamic> json) {
    if (json['popularExperiences'] != null) {
      popularExperiences = <Experiences>[];
      json['popularExperiences'].forEach((v) {
        popularExperiences!.add(Experiences.fromJson(v));
      });
    }
    if (json['allExperience'] != null) {
      allExperiences = <Experiences>[];
      json['allExperience'].forEach((v) {
        allExperiences!.add(Experiences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (popularExperiences != null) {
      data['popularExperiences'] = popularExperiences!.map((v) => v.toJson()).toList();
    }
    if (allExperiences != null) {
      data['allExperience'] =
          allExperiences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Experiences {
  int? id;
  int? chefId;
  String? chefName;
  String? chefBrandName;
  String? chefAddress;
  String? title;
  String? description;
  dynamic wowFactorId;
  dynamic preferenceId;
  int? price;
  int? priceTypeId;
  String? persons;
  int? personMaxLimit;
  int? locationId;
  String? subHostName;
  String? subHostMobileNo;
  List<ExperienceWowFactors>? experienceWowFactors;
  List<ExperiencePreferences>? experiencePreferences;
  List<ExperienceMedia>? experienceMedia;
  dynamic cityId;
  dynamic cityName;
  dynamic townId;
  dynamic townName;
  dynamic latitude;
  dynamic longitude;
  dynamic placeId;

  Experiences(
      {this.id,
        this.chefId,
        this.chefName,
        this.chefBrandName,
        this.chefAddress,
        this.title,
        this.description,
        this.wowFactorId,
        this.preferenceId,
        this.price,
        this.priceTypeId,
        this.persons,
        this.personMaxLimit,
        this.locationId,
        this.subHostName,
        this.subHostMobileNo,
        this.experienceWowFactors,
        this.experiencePreferences,
        this.experienceMedia,
        this.cityId,
        this.cityName,
        this.townId,
        this.townName,
        this.latitude,
        this.longitude,
        this.placeId});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chefId = json['chefId'];
    chefName = json['chefName'];
    chefBrandName = json['chefBrandName'];
    chefAddress = json['chefAddress'];
    title = json['title'];
    description = json['description'];
    wowFactorId = json['wowFactorId'];
    preferenceId = json['preferenceId'];
    price = json['price'];
    priceTypeId = json['priceTypeId'];
    persons = json['persons'];
    personMaxLimit = json['personMaxLimit'];
    locationId = json['locationId'];
    subHostName = json['subHostName'];
    subHostMobileNo = json['subHostMobileNo'];
    if (json['experienceWowFactors'] != null) {
      experienceWowFactors = <ExperienceWowFactors>[];
      json['experienceWowFactors'].forEach((v) {
        experienceWowFactors!.add(ExperienceWowFactors.fromJson(v));
      });
    }
    if (json['experiencePreferences'] != null) {
      experiencePreferences = <ExperiencePreferences>[];
      json['experiencePreferences'].forEach((v) {
        experiencePreferences!.add(ExperiencePreferences.fromJson(v));
      });
    }
    if (json['experienceMedia'] != null) {
      experienceMedia = [];
      json['experienceMedia'].forEach((v) {
        experienceMedia!.add(v);
      });
    }
    cityId = json['cityId'];
    cityName = json['cityName'];
    townId = json['townId'];
    townName = json['townName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['chefId'] = chefId;
    data['chefName'] = chefName;
    data['chefBrandName'] = chefBrandName;
    data['chefAddress'] = chefAddress;
    data['title'] = title;
    data['description'] = description;
    data['wowFactorId'] = wowFactorId;
    data['preferenceId'] = preferenceId;
    data['price'] = price;
    data['priceTypeId'] = priceTypeId;
    data['persons'] = persons;
    data['personMaxLimit'] = personMaxLimit;
    data['locationId'] = locationId;
    data['subHostName'] = subHostName;
    data['subHostMobileNo'] = subHostMobileNo;
    if (experienceWowFactors != null) {
      data['experienceWowFactors'] =
          experienceWowFactors!.map((v) => v.toJson()).toList();
    }
    if (experiencePreferences != null) {
      data['experiencePreferences'] =
          experiencePreferences!.map((v) => v.toJson()).toList();
    }
    if (experienceMedia != null) {
      data['experienceMedia'] =
          experienceMedia!.map((v) => v.toJson()).toList();
    }
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['townId'] = townId;
    data['townName'] = townName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['placeId'] = placeId;
    return data;
  }
}

class ExperienceWowFactors {
  int? id;
  int? experienceId;
  int? wowFactorId;
  String? wowFactorName;
  String? wowFactorDescription;
  String? wowFactorIconPath;

  ExperienceWowFactors(
      {this.id,
        this.experienceId,
        this.wowFactorId,
        this.wowFactorName,
        this.wowFactorDescription,
        this.wowFactorIconPath});

  ExperienceWowFactors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    experienceId = json['experienceId'];
    wowFactorId = json['wowFactorId'];
    wowFactorName = json['wowFactorName'];
    wowFactorDescription = json['wowFactorDescription'];
    wowFactorIconPath = json['wowFactorIconPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['experienceId'] = experienceId;
    data['wowFactorId'] = wowFactorId;
    data['wowFactorName'] = wowFactorName;
    data['wowFactorDescription'] = wowFactorDescription;
    data['wowFactorIconPath'] = wowFactorIconPath;
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
  int? id;
  int? experienceId;
  int? preferenceId;
  String? preferenceName;
  String? preferenceDescription;
  String? preferenceIconPath;

  ExperiencePreferences(
      {this.id,
        this.experienceId,
        this.preferenceId,
        this.preferenceName,
        this.preferenceDescription,
        this.preferenceIconPath});

  ExperiencePreferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    experienceId = json['experienceId'];
    preferenceId = json['preferenceId'];
    preferenceName = json['preferenceName'];
    preferenceDescription = json['preferenceDescription'];
    preferenceIconPath = json['preferenceIconPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['experienceId'] = experienceId;
    data['preferenceId'] = preferenceId;
    data['preferenceName'] = preferenceName;
    data['preferenceDescription'] = preferenceDescription;
    data['preferenceIconPath'] = preferenceIconPath;
    return data;
  }
}

class ExperienceMenus {
  int? id;
  String? dish;
  int? mealId;
  String? mealName;
  int? baseDishId;
  String? baseDishName;
  int? experienceId;
  String? description;
  int? price;
  String? pictureUrl;

  ExperienceMenus(
      {this.id,
        this.dish,
        this.mealId,
        this.mealName,
        this.baseDishId,
        this.baseDishName,
        this.experienceId,
        this.description,
        this.price,
        this.pictureUrl});

  ExperienceMenus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dish = json['dish'];
    mealId = json['mealId'];
    mealName = json['mealName'];
    baseDishId = json['baseDishId'];
    baseDishName = json['baseDishName'];
    experienceId = json['experienceId'];
    description = json['description'];
    price = json['price'];
    pictureUrl = json['pictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['dish'] = dish;
    data['mealId'] = mealId;
    data['mealName'] = mealName;
    data['baseDishId'] = baseDishId;
    data['baseDishName'] = baseDishName;
    data['experienceId'] = experienceId;
    data['description'] = description;
    data['price'] = price;
    data['pictureUrl'] = pictureUrl;
    return data;
  }
}