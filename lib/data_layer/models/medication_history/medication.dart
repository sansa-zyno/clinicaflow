// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:healtether_clinic_app/data_layer/models/prescription/prescription.dart';

class Medication {
  final String id;
  final String type;
  final Prescription prescription;
  final String appointmentId;
  final String userId;
  final String clinicId;
  final bool isDeleted;
  final Map<String, dynamic> createdBy;
  final Map<String, dynamic> updatedBy;
  final String createdAt;
  final String updatedAt;
  Medication({
    required this.id,
    required this.type,
    required this.prescription,
    required this.appointmentId,
    required this.userId,
    required this.clinicId,
    required this.isDeleted,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });
  //
  //    "_id": "66b4b0e076b4a71047281c40",
  //    "type": "present",
  //    "prescription": {
  //        "id": "620a844a4a6163099f7a6f83",
  //        "name": "Medication Name",
  //        "content": "Medication Content",
  //        "dosage": 10,
  //        "frequency": "daily",
  //        "days": 30,
  //        "time": [
  //            "morning",
  //            "evening"
  //        ],
  //        "note": [
  //            "Take with water"
  //        ]
  //    },
  //    "appointment_id": "620a844a4a6163099f7a6f84",
  //    "user_id": "620a844a4a6163099f7a6f85",
  //    "clinic_id": "620a844a4a6163099f7a6f86",
  //    "is_deleted": false,
  //    "created_by": {
  //        "id": "662ca0ab1a2431e16c41ebae",
  //        "name": "Venkatesh Raja"
  //    },
  //    "updated_by": {
  //        "id": "662ca0ab1a2431e16c41ebae",
  //        "name": "Venkatesh Raja"
  //    },
  //    "createdAt": "2024-08-08T11:49:52.642Z",
  //    "updatedAt": "2024-08-08T11:49:52.642Z",
  //    "__v": 0

  Medication copyWith({
    String? id,
    String? type,
    Prescription? prescription,
    String? appointmentId,
    String? userId,
    String? clinicId,
    bool? isDeleted,
    Map<String, dynamic>? createdBy,
    Map<String, dynamic>? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return Medication(
      id: id ?? this.id,
      type: type ?? this.type,
      prescription: prescription ?? this.prescription,
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
      'type': type,
      'prescription': prescription.toMap(),
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

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'] as String,
      type: map['type'] as String,
      prescription: Prescription.fromMap(map['prescription'] as Map<String,dynamic>),
      appointmentId: map['appointmentId'] as String,
      userId: map['userId'] as String,
      clinicId: map['clinicId'] as String,
      isDeleted: map['isDeleted'] as bool,
      createdBy: Map<String, dynamic>.from((map['createdBy'] as Map<String, dynamic>)),
      updatedBy: Map<String, dynamic>.from((map['updatedBy'] as Map<String, dynamic>)),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Medication.fromJson(String source) => Medication.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Medication other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  String toString() {
    return 'Medication(id: $id, type: $type, prescription: $prescription, appointmentId: $appointmentId, userId: $userId, clinicId: $clinicId, isDeleted: $isDeleted, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
