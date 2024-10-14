import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Vital {
  final Map<String, dynamic>? value;
  final String? id;
  final String? type;
  final String? appointmentId;
  final String? userId;
  final bool? isDeleted;
  final String? clinicId;
  final Map<String, dynamic>? createdBy;
  final Map<String, dynamic>? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  Vital({
    this.value,
    this.id,
    this.type,
    this.appointmentId,
    this.userId,
    this.isDeleted,
    this.clinicId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  // {
  //      "value": {
  //          "real": 11,
  //          "fraction": 80
  //      },
  //      "_id": "66abe456febd3cd17ee336b3",
  //      "type": "blood_presure",
  //      "appointment_id": "66922a13dbdcdf6632e7ae4e",
  //      "user_id": "668fa05fdbdcdf6632e7ac6f",
  //      "is_deleted": false,
  //      "clinic_id": "662ca0a41a2431e16c41ebaa",
  //      "created_by": {
  //          "id": "662ca0ab1a2431e16c41ebae",
  //          "name": "Venkatesh Raja"
  //      },
  //      "updated_by": {
  //          "id": "662ca0ab1a2431e16c41ebae",
  //          "name": "Venkatesh Raja"
  //      },
  //      "createdAt": "2024-08-01T19:39:02.988Z",
  //      "updatedAt": "2024-08-01T20:20:59.646Z",
  //      "__v": 0
  //  }

  @override
  String toString() {
    return 'Vital(value: $value, id: $id, type: $type, appointmentId: $appointmentId, userId: $userId, isDeleted: $isDeleted, clinicId: $clinicId, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'id': id,
      'type': type,
      'appointmentId': appointmentId,
      'userId': userId,
      'isDeleted': isDeleted,
      'clinicId': clinicId,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Vital.fromMap(Map<String, dynamic> map) {
    for (var key in map.keys) {
      log("key, value: $key, ${map[key]}");
    }
    final vital = Vital(
      value: map['value'] != null
          ? Map<String, dynamic>.from((map['value'] as Map<String, dynamic>))
          : null,
      id: map['_id'] != null ? map['_id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      appointmentId: map['appointment_id'] != null
          ? map['appointment_id'] as String
          : null,
      userId: map['user_id'] != null ? map['user_id'] as String : null,
      isDeleted: map['is_deleted'] != null ? map['is_deleted'] as bool : null,
      clinicId: map['clinic_id'] != null ? map['clinic_id'] as String : null,
      createdBy: map['createdBy'] != null
          ? Map<String, dynamic>.from(
              (map['createdBy'] as Map<String, dynamic>))
          : null,
      updatedBy: map['updatedBy'] != null
          ? Map<String, dynamic>.from(
              (map['updatedBy'] as Map<String, dynamic>))
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );

    log("parsed vital = $vital");

    return vital;
  }

  String toJson() => json.encode(toMap());

  factory Vital.fromJson(String source) =>
      Vital.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Vital other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
