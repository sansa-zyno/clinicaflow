import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Prescription {
  final String id;
  final String name;
  final String content;
  final double dosage;
  final String frequency;
  final int days;
  final List<String> time;
  final List<String> note;
  Prescription({
    required this.id,
    required this.name,
    required this.content,
    required this.dosage,
    required this.frequency,
    required this.days,
    required this.time,
    required this.note,
  });
  //"prescription": {
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

  Prescription copyWith({
    String? id,
    String? name,
    String? content,
    double? dosage,
    String? frequency,
    int? days,
    List<String>? time,
    List<String>? note,
  }) {
    return Prescription(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      days: days ?? this.days,
      time: time ?? this.time,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'content': content,
      'dosage': dosage,
      'frequency': frequency,
      'days': days,
      'time': time,
      'note': note,
    };
  }

  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      id: map['id'] as String,
      name: map['name'] as String,
      content: map['content'] as String,
      dosage: double.parse(map['dosage'].toString()),
      frequency: map['frequency'] as String,
      days: map['days'] as int,
      time: List<String>.from((map['time'] as List<dynamic>)),
      note: List<String>.from((map['note'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Prescription.fromJson(String source) =>
      Prescription.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Prescription(id: $id, name: $name, content: $content, dosage: $dosage, frequency: $frequency, days: $days, time: $time, note: $note)';
  }

  @override
  bool operator ==(covariant Prescription other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
