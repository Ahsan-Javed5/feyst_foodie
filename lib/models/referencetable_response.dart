import 'dart:convert';

ReferenceTableRecord referenceTableRecordFromJson(String str) =>
    ReferenceTableRecord.fromJson(json.decode(str));

String referenceTableRecordToJson(ReferenceTableRecord data) =>
    json.encode(data.toJson());

class ReferenceTableRecord {
  factory ReferenceTableRecord.fromJson(Map<String, dynamic> json) =>
      ReferenceTableRecord(
        rows: List<Row>.from(json['rows'].map((x) => Row.fromJson(x))),
        total: json['total'],
        page: json['page'],
        pageSize: json['pageSize'],
        totalPages: json['totalPages'],
      );
  ReferenceTableRecord({
    this.rows,
    this.total,
    this.page,
    this.pageSize,
    this.totalPages,
  });

  List<Row>? rows;
  int? total;
  int? page;
  int? pageSize;
  int? totalPages;

  Map<String, dynamic> toJson() => {
        'rows': List<dynamic>.from(rows!.map((x) => x.toJson())),
        'total': total,
        'page': page,
        'pageSize': pageSize,
        'totalPages': totalPages,
      };
}

class Row {
  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['_id'],
        createdBy: json['createdBy'],
        updatedBy: json['updatedBy'],
        isDeleted: json['isDeleted'],
        customFields: json['customFields'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        tenantId: json['tenantID'],
        refId: json['refId'],
        v: json['__v'],
      );
  Row({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.customFields,
    this.createdAt,
    this.updatedAt,
    this.tenantId,
    this.refId,
    this.v,
  });

  String? id;
  String? createdBy;
  String? updatedBy;
  bool? isDeleted;
  final Map<String, dynamic>? customFields;
  String? createdAt;
  String? updatedAt;
  String? tenantId;
  String? refId;
  int? v;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'createdBy': createdBy,
        'updatedBy': updatedBy,
        'isDeleted': isDeleted,
        'customFields': customFields,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'tenantID': tenantId,
        'refId': refId,
        '__v': v,
      };
}
