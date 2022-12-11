// To parse this JSON data, do
//
//     final menus = menusFromJson(jsonString);

import 'dart:convert';

Menus menusFromJson(String str) => Menus.fromJson(json.decode(str));

String menusToJson(Menus data) => json.encode(data.toJson());

class Menus {
  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
        success: json['success'],
      );
  Menus({
    this.data,
    this.success,
  });

  List<Datum>? data;
  bool? success;

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'success': success,
      };
}

class Datum {
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json['name'] ?? null,
        label: json['label'],
        type: json['type'],
        children:
            List<Child>.from(json['children'].map((x) => Child.fromJson(x))),
        order: json['order'] ?? null,
      );
  Datum({
    this.name,
    this.label,
    this.type,
    this.children,
    this.order,
  });

  String? name;
  String? label;
  String? type;
  List<Child>? children;
  int? order;

  Map<String, dynamic> toJson() => {
        'name': name ?? null,
        'label': label,
        'type': type,
        'children': List<dynamic>.from(children!.map((x) => x.toJson())),
        'order': order ?? null,
      };
}

class Child {
  factory Child.fromJson(Map<String, dynamic> json) => Child(
        name: json['name'] ?? null,
        label: json['label'],
        type: json['type'] ?? null,
        meta: Meta.fromJson(json['meta']),
      );
  Child({
    this.name,
    this.label,
    this.type,
    this.meta,
  });

  String? name;
  String? label;
  String? type;
  Meta? meta;

  Map<String, dynamic> toJson() => {
        'name': name ?? null,
        'label': label,
        'type': type ?? null,
        'meta': meta!.toJson(),
      };
}

class Meta {
  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        iframe: json['iframe'] == null ? null : Iframe.fromJson(json['iframe']),
        type: json['type'] ?? null,
        master: json['master'] == null ? null : Master.fromJson(json['master']),
        module:
            json['module'] == null ? null : ModuleMenu.fromJson(json['module']),
      );
  Meta({
    this.iframe,
    this.type,
    this.master,
    this.module,
  });

  Iframe? iframe;
  String? type;
  Master? master;
  ModuleMenu? module;

  Map<String, dynamic> toJson() => {
        'iframe': iframe == null ? null : iframe!.toJson(),
        'type': type ?? null,
        'master': master == null ? null : master!.toJson(),
        'module': module == null ? null : module!.toJson(),
      };
}

class Iframe {
  factory Iframe.fromJson(Map<String, dynamic> json) => Iframe(
        url: json['url'],
      );
  Iframe({
    this.url,
  });

  String? url;

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}

class Master {
  factory Master.fromJson(Map<String, dynamic> json) => Master(
        refId: json['refId'],
      );
  Master({
    this.refId,
  });

  String? refId;

  Map<String, dynamic> toJson() => {
        'refId': refId,
      };
}

class ModuleMenu {
  factory ModuleMenu.fromJson(Map<String, dynamic> json) => ModuleMenu(
        moduleId: json['moduleID'],
        isNative: json['isNative'] ?? null,
      );
  ModuleMenu({
    this.moduleId,
    this.isNative,
  });

  String? moduleId;
  bool? isNative;

  Map<String, dynamic> toJson() => {
        'moduleID': moduleId,
        'isNative': isNative ?? null,
      };
}
