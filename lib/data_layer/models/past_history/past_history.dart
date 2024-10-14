import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PastHistory {
  final String id;
  final String? type;
  final String disease;
  final String diseaseDate;
  final String appointmentId;
  final String unit;
  final double duration;
  final List<dynamic> notes;
  final String? userId;
  final String clinicId;
  final bool isDeleted;
  final Map<String, dynamic>? createdBy;
  final Map<String, dynamic>? updatedBy;
  final String createdAt;
  final String updatedAt;

  // {
  //     "_id": "66ac7b58febd3cd17ee3406f",
  //     "type": "user",
  //     "disease": "chronic disease",
  //     "disease_date": "2024-08-02T00:00:00.000Z",
  //     "appointment_id": "668d61c7dbdcdf6632e7a7b0",
  //     "unit": "Months",
  //     "duration": 2,
  //     "notes": [],
  //     "user_id": "668d6129dbdcdf6632e7a73a",
  //     "clinic_id": "662ca0a41a2431e16c41ebaa",
  //     "is_deleted": false,
  //     "created_by": {
  //         "id": "662ca0ab1a2431e16c41ebae",
  //         "name": "Venkatesh Raja"
  //     },
  //     "updated_by": {
  //         "id": "662ca0ab1a2431e16c41ebae",
  //         "name": "Venkatesh Raja"
  //     },
  //     "createdAt": "2024-08-02T06:23:20.300Z",
  //     "updatedAt": "2024-08-02T06:23:20.300Z",
  //     "__v": 0
  // }

  const PastHistory(
    this.id,
    this.type,
    this.disease,
    this.diseaseDate,
    this.appointmentId,
    this.unit,
    this.duration,
    this.notes,
    this.userId,
    this.clinicId,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type,
      'disease': disease,
      'diseaseDate': diseaseDate,
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

  factory PastHistory.fromMap(Map<String, dynamic> map) {
    return PastHistory(
      map['_id'] as String,
      map['type'] != null ? map['type'] as String : null,
      map['disease'] as String,
      map['disease_date'] as String,
      map['appointment_id'] as String,
      map['unit'] as String,
      double.parse(map['duration'].toString()),
      List<dynamic>.from((map['notes'] as List<dynamic>)),
      map['user_id'] != null ? map['user_id'] as String : null,
      map['clinic_id'] as String,
      map['is_deleted'] as bool,
      map['created_by'] != null ? Map<String, dynamic>.from((map['created_by'] as Map<String, dynamic>)) : null,
      map['updated_by'] != null ? Map<String, dynamic>.from((map['updated_by'] as Map<String, dynamic>)) : null,
      map['createdAt'] as String,
      map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PastHistory.fromJson(String source) => PastHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PastHistory(id: $id, type: $type, disease: $disease, diseaseDate: $diseaseDate, appointmentId: $appointmentId, unit: $unit, duration: $duration, notes: $notes, userId: $userId, clinicId: $clinicId, isDeleted: $isDeleted, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant PastHistory other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  PastHistory copyWith({
    String? id,
    String? type,
    String? disease,
    String? diseaseDate,
    String? appointmentId,
    String? unit,
    double? duration,
    List<dynamic>? notes,
    String? userId,
    String? clinicId,
    bool? isDeleted,
    Map<String, dynamic>? createdBy,
    Map<String, dynamic>? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return PastHistory(
      id ?? this.id,
      type ?? this.type,
      disease ?? this.disease,
      diseaseDate ?? this.diseaseDate,
      appointmentId ?? this.appointmentId,
      unit ?? this.unit,
      duration ?? this.duration,
      notes ?? this.notes,
      userId ?? this.userId,
      clinicId ?? this.clinicId,
      isDeleted ?? this.isDeleted,
      createdBy ?? this.createdBy,
      updatedBy ?? this.updatedBy,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }
}
