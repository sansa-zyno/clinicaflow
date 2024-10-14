// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Drug {
  final String name;
  final String contents;
  final String? type; // syp, tab, inj
  final int? quantity;
  final String? dosageFrequency;
  final String? dosageTime;
  final String? duration;
  Drug({
    required this.name,
    required this.contents,
    this.type,
    this.quantity,
    this.dosageFrequency,
    this.dosageTime,
    this.duration,
  });

  Drug copyWith({
    String? name,
    String? contents,
    String? type,
    int? quantity,
    String? dosageFrequency,
    String? dosageTime,
    String? duration,
  }) {
    return Drug(
      name: name ?? this.name,
      contents: contents ?? this.contents,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      dosageFrequency: dosageFrequency ?? this.dosageFrequency,
      dosageTime: dosageTime ?? this.dosageTime,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'contents': contents,
      'type': type,
      'quantity': quantity,
      'dosageFrequency': dosageFrequency,
      'dosageTime': dosageTime,
      'duration': duration,
    };
  }

  factory Drug.fromMap(Map<String, dynamic> map) {
    return Drug(
      name: map['name'] as String,
      contents: map['contents'] != null ? map['contents'] as String : '',
      type: map['type'] != null ? map['type'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      dosageFrequency: map['dosageFrequency'] != null ? map['dosageFrequency'] as String : null,
      dosageTime: map['dosageTime'] != null ? map['dosageTime'] as String : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Drug.fromJson(String source) => Drug.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Drug(name: $name, contents: $contents, type: $type, quantity: $quantity, dosageFrequency: $dosageFrequency, dosageTime: $dosageTime, duration: $duration)';
  }

  @override
  bool operator ==(covariant Drug other) {
    if (identical(this, other)) return true;

    return other.contents == contents;
  }

  @override
  int get hashCode {
    return contents.hashCode;
  }
}
