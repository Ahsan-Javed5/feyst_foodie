class HomeResponse {
  T? t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int? code;

  HomeResponse({this.t, this.userId, this.message, this.error, this.code});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? new T.fromJson(json['t']) : null;
    userId = json['userId'];
    message = json['message'];
    error = json['error'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    data['userId'] = this.userId;
    data['message'] = this.message;
    data['error'] = this.error;
    data['code'] = this.code;
    return data;
  }
}

class T {
  List<Experiences>? experiences;
  List<ExperienceMenus>? experienceMenus;

  T({this.experiences, this.experienceMenus});

  T.fromJson(Map<String, dynamic> json) {
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(new Experiences.fromJson(v));
      });
    }
    if (json['experienceMenus'] != null) {
      experienceMenus = <ExperienceMenus>[];
      json['experienceMenus'].forEach((v) {
        experienceMenus!.add(new ExperienceMenus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.experiences != null) {
      data['experiences'] = this.experiences!.map((v) => v.toJson()).toList();
    }
    if (this.experienceMenus != null) {
      data['experienceMenus'] =
          this.experienceMenus!.map((v) => v.toJson()).toList();
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
  List<dynamic>? experienceMedia;
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
    data['chefId'] = this.chefId;
    data['chefName'] = this.chefName;
    data['chefBrandName'] = this.chefBrandName;
    data['chefAddress'] = this.chefAddress;
    data['title'] = this.title;
    data['description'] = this.description;
    data['wowFactorId'] = this.wowFactorId;
    data['preferenceId'] = this.preferenceId;
    data['price'] = this.price;
    data['priceTypeId'] = this.priceTypeId;
    data['persons'] = this.persons;
    data['personMaxLimit'] = this.personMaxLimit;
    data['locationId'] = this.locationId;
    data['subHostName'] = this.subHostName;
    data['subHostMobileNo'] = this.subHostMobileNo;
    if (this.experienceWowFactors != null) {
      data['experienceWowFactors'] =
          this.experienceWowFactors!.map((v) => v.toJson()).toList();
    }
    if (this.experiencePreferences != null) {
      data['experiencePreferences'] =
          this.experiencePreferences!.map((v) => v.toJson()).toList();
    }
    if (this.experienceMedia != null) {
      data['experienceMedia'] =
          this.experienceMedia!.map((v) => v.toJson()).toList();
    }
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['townId'] = this.townId;
    data['townName'] = this.townName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['placeId'] = this.placeId;
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
    data['id'] = this.id;
    data['experienceId'] = this.experienceId;
    data['wowFactorId'] = this.wowFactorId;
    data['wowFactorName'] = this.wowFactorName;
    data['wowFactorDescription'] = this.wowFactorDescription;
    data['wowFactorIconPath'] = this.wowFactorIconPath;
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
    data['id'] = this.id;
    data['experienceId'] = this.experienceId;
    data['preferenceId'] = this.preferenceId;
    data['preferenceName'] = this.preferenceName;
    data['preferenceDescription'] = this.preferenceDescription;
    data['preferenceIconPath'] = this.preferenceIconPath;
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
    data['id'] = this.id;
    data['dish'] = this.dish;
    data['mealId'] = this.mealId;
    data['mealName'] = this.mealName;
    data['baseDishId'] = this.baseDishId;
    data['baseDishName'] = this.baseDishName;
    data['experienceId'] = this.experienceId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['pictureUrl'] = this.pictureUrl;
    return data;
  }
}