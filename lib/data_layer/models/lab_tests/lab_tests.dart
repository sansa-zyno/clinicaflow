// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class LabTest {
  final String name;
  final List<String>? note;
  final bool reapeat;
  const LabTest({
    required this.name,
    this.note,
    this.reapeat = false,
  });

  LabTest copyWith({
    String? name,
    List<String>? note,
    bool? reapeat,
  }) {
    return LabTest(
      name: name ?? this.name,
      note: note ?? this.note,
      reapeat: reapeat ?? this.reapeat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'note': note,
      'reapeat': reapeat,
    };
  }

  factory LabTest.fromMap(Map<String, dynamic> map) {
    return LabTest(
      name: map['name'] as String,
      note: map['note'] != null ? List<String>.from((map['note'] as List<dynamic>)) : null,
      reapeat: (map['reapeat'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LabTest.fromJson(String source) =>
      LabTest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LabTest(name: $name, note: $note, reapeat: $reapeat)';

  @override
  bool operator ==(covariant LabTest other) {
    if (identical(this, other)) return true;
    

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
