import 'dart:convert';
import 'dart:ui';

import 'package:chef/models/models.dart';

CheckList checkListFromJson(String str) => CheckList.fromJson(json.decode(str));

String checkListToJson(CheckList data) => json.encode(data.toJson());

ExistingCheckList existingCheckListFromJson(String str) =>
    ExistingCheckList.fromJson(json.decode(str));

String existingCheckListToJson(ExistingCheckList data) =>
    json.encode(data.toJson());

class ExistingCheckList {
  factory ExistingCheckList.fromJson(Map<String, dynamic> json) =>
      ExistingCheckList(
        id: json['_id'],
        seqNumber: json['seqNumber'],
        recordNumber: json['recordNumber'],
        tenantId: json['tenantID'],
        projectId: json['projectID'],
        workspaceRefId: json['workspaceRefId'],
        customFields: json['customFields'] == null
            ? null
            : CustomFields.fromJson(json['customFields']),
        customLineItems: json['customLineItems'] == null
            ? null
            : List<dynamic>.from(json['customLineItems'].map((x) => x)),
        checklist: json['checklist'] != null
            ? List<CheckList>.from(
                json['checklist'].map((x) => CheckList.fromJson(x)),
              )
            : null,
        refId: json['refID'],
        space: json['space'] == null ? null : Space.fromJson(json['space']),
        createdBy: json['createdBy'],
        updatedBy: json['updatedBy'],
        isDeleted: json['isDeleted'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt']),
        workflowTemplateId: json['workflowTemplateID'],
        v: json['__v'],
      );
  ExistingCheckList({
    this.id,
    this.seqNumber,
    this.recordNumber,
    this.tenantId,
    this.projectId,
    this.workspaceRefId,
    this.customFields,
    this.customLineItems,
    this.checklist,
    this.refId,
    this.space,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.workflowTemplateId,
    this.v,
  });

  String? id;
  int? seqNumber;
  String? recordNumber;
  String? tenantId;
  String? projectId;
  String? workspaceRefId;
  CustomFields? customFields;
  List<dynamic>? customLineItems;
  List<CheckList>? checklist;
  String? refId;
  Space? space;
  String? createdBy;
  String? updatedBy;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? workflowTemplateId;
  int? v;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'seqNumber': seqNumber,
        'recordNumber': recordNumber,
        'tenantID': tenantId,
        'projectID': projectId,
        'workspaceRefId': workspaceRefId,
        'customFields': customFields == null ? null : customFields!.toJson(),
        'customLineItems': customLineItems == null
            ? null
            : List<dynamic>.from(customLineItems!.map((x) => x)),
        'checklist': checklist == null
            ? null
            : List<dynamic>.from(checklist!.map((x) => x.toJson())),
        'refID': refId,
        'space': space == null ? null : space!.toJson(),
        'createdBy': createdBy,
        'updatedBy': updatedBy,
        'isDeleted': isDeleted,
        'createdAt': createdAt == null ? null : createdAt!.toIso8601String(),
        'updatedAt': updatedAt == null ? null : updatedAt!.toIso8601String(),
        'workflowTemplateID': workflowTemplateId,
        '__v': v,
      };
}

class CheckList {
  factory CheckList.fromJson(Map<String, dynamic> json) => CheckList(
        id: json['ID'],
        checklistId: json['_id'],
        name: json['name'],
        version: json['version'],
        tenantId: json['tenantID'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'],
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt']),
        updatedBy: json['updatedBy'],
        items: json['items'] == null
            ? null
            : List<CheckListItem>.from(
                json['items'].map((x) => CheckListItem.fromJson(x)),
              ),
      );
  CheckList({
    this.id,
    this.checklistId,
    this.name,
    this.version,
    this.tenantId,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.items,
  });

  String? id;
  String? checklistId;
  String? name;
  int? version;
  String? tenantId;
  DateTime? createdAt;
  String? createdBy;
  DateTime? updatedAt;
  String? updatedBy;
  List<CheckListItem>? items;

  Map<String, dynamic> toJson() => {
        'ID': id,
        '_id': checklistId,
        'name': name,
        'version': version,
        'tenantID': tenantId,
        'createdAt': createdAt == null ? null : createdAt!.toIso8601String(),
        'createdBy': createdBy,
        'updatedAt': updatedAt == null ? null : updatedAt!.toIso8601String(),
        'updatedBy': updatedBy,
        'items': items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class CheckListItem {
  factory CheckListItem.fromJson(Map<String, dynamic> json) => CheckListItem(
        id: json['_id'],
        itemId: json['id'],
        description: json['description'],
        uiType:
            json['uiType'] == null ? null : uiTypeValues.map![json['uiType']],
        options: json['options'] == null
            ? null
            : List<Option>.from(json['options'].map((x) => Option.fromJson(x))),
        mandatory: json['mandatory'] == null
            ? null
            : attachmentsMandatoryValues.map![json['mandatory']],
        mandatoryWhenValueIs: json['mandatoryWhenValueIs'],
        showAudit: json['showAudit'],
        notes:
            json['notes'] == null ? null : Attachments.fromJson(json['notes']),
        linkedModules: json['linkedModules'] == null
            ? null
            : LinkedModules.fromJson(json['linkedModules']),
        attachments: json['attachments'] == null
            ? null
            : Attachments.fromJson(json['attachments']),
        items: json['items'] == null
            ? null
            : List<Item>.from(
                json['items'].map((x) => Item.fromJson(x)),
              ),
        value: json['value'],
        filledAt:
            json['filledAt'] == null ? null : DateTime.parse(json['filledAt']),
        filledBy: json['filledBy'] == null
            ? null
            : FilledBy.fromJson(json['filledBy']),
      );
  CheckListItem({
    this.id,
    this.itemId,
    this.description,
    this.uiType,
    this.options,
    this.mandatory,
    this.mandatoryWhenValueIs,
    this.showAudit,
    this.notes,
    this.linkedModules,
    this.attachments,
    this.items,
    this.value,
    this.filledAt,
    this.filledBy,
  });

  String? id;
  String? itemId;
  String? description;
  UiType? uiType;
  List<Option>? options;
  AttachmentsMandatory? mandatory;
  String? mandatoryWhenValueIs;
  bool? showAudit;
  Attachments? notes;
  LinkedModules? linkedModules;
  Attachments? attachments;
  List<Item>? items;
  final Map<String, dynamic>? value;
  DateTime? filledAt;
  FilledBy? filledBy;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'id': itemId,
        'description': description,
        'uiType': uiType == null ? null : uiTypeValues.reverse[uiType],
        'options': options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        'mandatory': mandatory == null
            ? null
            : attachmentsMandatoryValues.reverse[mandatory],
        'mandatoryWhenValueIs': mandatoryWhenValueIs,
        'showAudit': showAudit,
        'notes': notes == null ? null : notes!.toJson(),
        'linkedModules': linkedModules == null ? null : linkedModules!.toJson(),
        'attachments': attachments == null ? null : attachments!.toJson(),
        'items': items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        'value': value,
        'filledAt': filledAt == null ? null : filledAt!.toIso8601String(),
        'filledBy': filledBy == null ? null : filledBy!.toJson(),
      };
}

class Attachments {
  factory Attachments.fromJson(Map<String, dynamic> json) => Attachments(
        mandatory: json['mandatory'] == null
            ? null
            : attachmentsMandatoryValues.map![json['mandatory']],
        mandatoryWhenValueIs: json['mandatoryWhenValueIs'],
        show: json['show'],
        documents: json['documents'] == null
            ? null
            : List<dynamic>.from(json['documents'].map((x) => x)),
        value: json['value'],
      );
  Attachments({
    this.mandatory,
    this.mandatoryWhenValueIs,
    this.show,
    this.documents,
    this.value,
  });

  AttachmentsMandatory? mandatory;
  dynamic mandatoryWhenValueIs;
  bool? show;
  List<dynamic>? documents;
  dynamic value;

  Map<String, dynamic> toJson() => {
        'mandatory': mandatory == null
            ? null
            : attachmentsMandatoryValues.reverse[mandatory],
        'mandatoryWhenValueIs': mandatoryWhenValueIs,
        'show': show,
        'documents': documents == null
            ? null
            : List<dynamic>.from(documents!.map((x) => x)),
        'value': value,
      };
}

enum AttachmentsMandatory { never, whenValueIs }

final attachmentsMandatoryValues = EnumValues({
  'NEVER': AttachmentsMandatory.never,
  'WHEN_VALUE_IS': AttachmentsMandatory.whenValueIs
});

class FilledBy {
  factory FilledBy.fromJson(Map<String, dynamic> json) => FilledBy(
        fullName: json['fullName'] == null
            ? null
            : fullNameValues.map![json['fullName']],
        userName: json['userName'],
      );
  FilledBy({
    this.fullName,
    this.userName,
  });

  FullName? fullName;
  String? userName;

  Map<String, dynamic> toJson() => {
        'fullName': fullName == null ? null : fullNameValues.reverse[fullName],
        'userName': userName,
      };
}

enum FullName { efdalGunbay }

final fullNameValues = EnumValues({'Efdal Gunbay': FullName.efdalGunbay});

class Item {
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        description: json['description'],
        uiType:
            json['uiType'] != null ? uiTypeValues.map![json['uiType']] : null,
        options: json['options'] == null
            ? null
            : List<Option>.from(json['options'].map((x) => Option.fromJson(x))),
        mandatory: json['mandatory'] == null
            ? null
            : purpleMandatoryValues.map![json['mandatory']],
        mandatoryWhenValueIs: json['mandatoryWhenValueIs'],
        showAudit: json['showAudit'],
        warnWhenValueIs: json['warnWhenValueIs'],
        notes:
            json['notes'] == null ? null : Attachments.fromJson(json['notes']),
        linkedModules: json['linkedModules'] == null
            ? null
            : LinkedModules.fromJson(json['linkedModules']),
        attachments: json['attachments'] == null
            ? null
            : Attachments.fromJson(json['attachments']),
        value: json['value'],
        items: json['items'] == null
            ? null
            : List<Item>.from(json['items'].map((x) => x)),
        filledAt:
            json['filledAt'] == null ? null : DateTime.parse(json['filledAt']),
        filledBy: json['filledBy'] == null
            ? null
            : FilledBy.fromJson(json['filledBy']),
      );
  Item({
    this.id,
    this.description,
    this.uiType,
    this.options,
    this.mandatory,
    this.mandatoryWhenValueIs,
    this.showAudit,
    this.warnWhenValueIs,
    this.notes,
    this.linkedModules,
    this.attachments,
    this.value,
    this.items,
    this.filledAt,
    this.filledBy,
  });

  String? id;
  String? description;
  UiType? uiType;
  List<Option>? options;
  Mandatory? mandatory;
  String? mandatoryWhenValueIs;
  bool? showAudit;
  String? warnWhenValueIs;
  Attachments? notes;
  LinkedModules? linkedModules;
  Attachments? attachments;
  List<dynamic>? value;
  final List<Item>? items;
  DateTime? filledAt;
  FilledBy? filledBy;

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'uiType': uiType != null ? uiTypeValues.reverse[uiType] : null,
        'options': options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        'mandatory':
            mandatory == null ? null : purpleMandatoryValues.reverse[mandatory],
        'mandatoryWhenValueIs': mandatoryWhenValueIs,
        'showAudit': showAudit,
        'warnWhenValueIs': warnWhenValueIs,
        'notes': notes == null ? null : notes!.toJson(),
        'linkedModules': linkedModules == null ? null : linkedModules!.toJson(),
        'attachments': attachments == null ? null : attachments!.toJson(),
        'value': value,
        'items':
            items == null ? null : List<dynamic>.from(items!.map((x) => x)),
        'filledAt': filledAt == null ? null : filledAt!.toIso8601String(),
        'filledBy': filledBy == null ? null : filledBy!.toJson(),
      };
}

class LinkedModules {
  factory LinkedModules.fromJson(Map<String, dynamic> json) => LinkedModules(
        enabled: json['enabled'],
        modules: json['modules'] == null
            ? null
            : List<ModuleData>.from(
                json['modules'].map((x) => ModuleData.fromJson(x)),
              ),
      );
  LinkedModules({
    this.enabled,
    this.modules,
  });

  bool? enabled;
  List<ModuleData>? modules;

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'modules': modules == null
            ? null
            : List<dynamic>.from(modules!.map((x) => x.toJson())),
      };
}

class ModuleData {
  factory ModuleData.fromJson(Map<String, dynamic> json) => ModuleData(
        moduleName: json['moduleName'] == null
            ? null
            : moduleNameValues.map![json['moduleName']],
        mandatory: json['mandatory'] == null
            ? null
            : attachmentsMandatoryValues.map![json['mandatory']],
        mandatoryWhenValueIs: json['mandatoryWhenValueIs'],
        records: json['records'] == null
            ? null
            : List<dynamic>.from(json['records'].map((x) => x)),
      );
  ModuleData({
    this.moduleName,
    this.mandatory,
    this.mandatoryWhenValueIs,
    this.records,
  });

  ModuleName? moduleName;
  AttachmentsMandatory? mandatory;
  String? mandatoryWhenValueIs;
  List<dynamic>? records;

  Map<String, dynamic> toJson() => {
        'moduleName':
            moduleName == null ? null : moduleNameValues.reverse[moduleName],
        'mandatory': mandatory == null
            ? null
            : attachmentsMandatoryValues.reverse[mandatory],
        'mandatoryWhenValueIs': mandatoryWhenValueIs,
        'records':
            records == null ? null : List<dynamic>.from(records!.map((x) => x)),
      };
}

enum WarnWhenValueIs { yes, no, pass, fail, notApplicable }

final warnWhenValueIsValues = EnumValues({
  'no': WarnWhenValueIs.no,
  'notApplicable': WarnWhenValueIs.notApplicable,
  'yes': WarnWhenValueIs.yes,
  'pass': WarnWhenValueIs.pass,
  'fail': WarnWhenValueIs.fail,
});

enum ModuleName { issue }

final moduleNameValues = EnumValues({'ISSUE': ModuleName.issue});

enum Mandatory { always, never }

final purpleMandatoryValues = EnumValues(
  {'ALWAYS': Mandatory.always, 'NEVER': Mandatory.never},
);

class Option {
  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json['id'],
        label: json['label'] == null ? null : labelValues.map![json['label']],
        value: json['value'],
        color: json['color'] == null ? null : colorValues.map![json['color']],
      );
  Option({
    this.id,
    this.label,
    this.value,
    this.color,
  });

  String? id;
  Label? label;
  String? value;
  Color? color;

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label == null ? null : labelValues.reverse[label],
        'value': value,
        'color': color == null ? null : colorValues.reverse[color],
      };
}

final colorValues = EnumValues({
  'green': const Color.fromRGBO(0, 128, 0, 0.5),
  'grey': const Color.fromRGBO(128, 128, 128, 0.5),
  'red': const Color.fromRGBO(139, 0, 0, 0.5),
});

enum Label { y, n, na, p, f }

final labelValues = EnumValues(
  {'N': Label.n, 'NA': Label.na, 'Y': Label.y, 'P': Label.p, 'F': Label.f},
);

enum UiType { radio, text }

final uiTypeValues = EnumValues({'RADIO': UiType.radio, 'TEXT': UiType.text});

class Value {
  factory Value.fromJson(Map<String, dynamic> json) => Value(
        fail: json['fail'],
        pass: json['pass'],
      );
  Value({
    this.fail,
    this.pass,
  });

  bool? fail;
  bool? pass;

  Value copyWith({
    bool? fail,
    bool? pass,
  }) =>
      Value(
        fail: fail ?? this.fail,
        pass: pass ?? this.pass,
      );

  Map<String, dynamic> toJson() => {
        'fail': fail,
        'pass': pass,
      };
}

class CustomFields {
  factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
        checkList: json['checklist'] != null
            ? List<CheckList>.from(
                json['checklist'].map((x) => CheckList.fromJson(x)),
              )
            : null,
        name: json['name'],
        extField: json['ext_field'] == null
            ? null
            : ExtField.fromJson(json['ext_field']),
      );
  CustomFields({
    this.checkList,
    this.name,
    this.extField,
  });

  List<CheckList>? checkList;
  String? name;
  ExtField? extField;

  Map<String, dynamic> toJson() => {
        'checklist': List<dynamic>.from(checkList!.map((x) => x.toJson())),
        'name': name,
        'ext_field': extField!.toJson(),
      };
}

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
