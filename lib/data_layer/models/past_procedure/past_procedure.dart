import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PastProcedure {
  final String id;
  final String procedure;
  final String procedureDate;
  final String appointmentId;
  final String unit;
  final String duration;
  final List<String> notes;
  final String userId;
  final String clinicId;
  final bool isDeleted;
  final Map<String, dynamic> createdBy;
  final Map<String, dynamic> updatedBy;
  final String? createdAt;
  final String? updatedAt;
  PastProcedure({
    required this.id,
    required this.procedure,
    required this.procedureDate,
    required this.appointmentId,
    required this.unit,
    required this.duration,
    required this.notes,
    required this.userId,
    required this.clinicId,
    required this.isDeleted,
    required this.createdBy,
    required this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  //{
  //     "_id": "66b45a6d76b4a710472819aa",
  //     "procedure": "Hypertension",
  //     "procedure_date": "2024-08-08T00:00:00.000Z",
  //     "appointment_id": "60c72b2f9b1d8e5f8c8a0b8f",
  //     "unit": "2",
  //     "duration": 1.5,
  //     "notes": [
  //         "Controlled with medication",
  //         "aaa"
  //     ],
  //     "user_id": "60c72b2f9b1d8e5f8c8a0b8f",
  //     "clinic_id": "60c72b2f9b1d8e5f8c8a0b8f",
  //     "is_deleted": false,
  //     "created_by": {
  //         "id": "662ca0ab1a2431e16c41ebae",
  //         "name": "Venkatesh Raja"
  //     },
  //     "updated_by": {
  //         "id": "662ca0ab1a2431e16c41ebae",
  //         "name": "Venkatesh Raja"
  //     },
  //     "createdAt": "2024-08-08T05:41:01.047Z",
  //     "updatedAt": "2024-08-08T05:41:01.047Z",
  //     "__v": 0
  // }

  PastProcedure copyWith({
    String? id,
    String? procedure,
    String? procedureDate,
    String? appointmentId,
    String? unit,
    String? duration,
    List<String>? notes,
    String? userId,
    String? clinicId,
    bool? isDeleted,
    Map<String, dynamic>? createdBy,
    Map<String, dynamic>? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return PastProcedure(
      id: id ?? this.id,
      procedure: procedure ?? this.procedure,
      procedureDate: procedureDate ?? this.procedureDate,
      appointmentId: appointmentId ?? this.appointmentId,
      unit: unit ?? this.unit,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
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
      'procedure': procedure,
      'procedureDate': procedureDate,
      'appointmentId': appointmentId,
      'unit': unit,
      'duration': duration,
      'notes': notes,
      'userId': userId,
      'clinicId': clinicId,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PastProcedure.fromMap(Map<String, dynamic> map) {
    return PastProcedure(
      id: map['_id'] as String,
      procedure: map['procedure'] as String,
      procedureDate: map['procedure_date'] as String,
      appointmentId: map['appointment_id'] as String,
      unit: map['unit'] as String,
      duration: map['duration'] as String,
      notes: List<String>.from((map['notes'] as List<dynamic>)),
      userId: map['user_id'] as String,
      clinicId: map['clinic_id'] as String,
      isDeleted: map['is_deleted'] as bool,
      createdBy: Map<String, dynamic>.from((map['created_by'] as Map<String, dynamic>)),
      updatedBy: Map<String, dynamic>.from((map['updated_by'] as Map<String, dynamic>)),
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PastProcedure.fromJson(String source) => PastProcedure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant PastProcedure other) {
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
    return 'PastProcedure(id: $id, procedure: $procedure, procedureDate: $procedureDate, appointmentId: $appointmentId, unit: $unit, duration: $duration, notes: $notes, userId: $userId, clinicId: $clinicId, isDeleted: $isDeleted, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
