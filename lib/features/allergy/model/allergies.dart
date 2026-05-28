// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:uuid/uuid.dart';

class Allergy {
  final String id;
  final String name;
  String? appointmentId;
  String? userId;
  String? clinicId;
  bool? isDeleted;
  Map<String, dynamic>? createdBy;
  Map<String, dynamic>? updatedBy;
  String? createdAt;
  String? updatedAt;
  Allergy({
    required this.id,
    required this.name,
    this.appointmentId,
    this.userId,
    this.clinicId,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  Allergy copyWith({
    String? id,
    String? name,
    String? appointmentId,
    String? userId,
    String? clinicId,
    bool? isDeleted,
    Map<String, dynamic>? createdBy,
    Map<String, dynamic>? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return Allergy(
      id: id ?? this.id,
      name: name ?? this.name,
      appointmentId: appointmentId ?? this.appointmentId,
      userId: userId ?? this.userId,
      clinicId: clinicId ?? this.clinicId,
      isDeleted: isDeleted ?? this.isDeleted,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'appointmentId': appointmentId,
      'userId': userId,
      'clinicId': clinicId,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Allergy.fromMap(Map<String, dynamic> map) {
    return Allergy(
      id: map['_id'] as String,
      name: map['name'] as String,
      appointmentId: map['appointmentId'] == null ? null : map['appointmentId'] as String,
      userId: map['userId'] == null ? null : map['userId'] as String,
      clinicId: map['clinicId'] == null ? null : map['clinicId'] as String,
      isDeleted: map['isDeleted'] == null ? null : map['isDeleted'] as bool,
      createdBy: map['createdBy'] == null ? null : Map<String, dynamic>.from((map['createdBy'] as Map<String, dynamic>)),
      updatedBy: map['updatedBy'] == null ? null : Map<String, dynamic>.from((map['updatedBy'] as Map<String, dynamic>)),
      createdAt: map['createdAt'] == null ? null : map['createdAt'] as String,
      updatedAt: map['updatedAt'] == null ? null : map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Allergy.empty() {
    return Allergy(id: Uuid().v4(), name: '');
  }

  factory Allergy.fromJson(String source) => Allergy.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Allergy(id: $id, name: $name, appointmentId: $appointmentId, userId: $userId, clinicId: $clinicId, isDeleted: $isDeleted, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Allergy other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
