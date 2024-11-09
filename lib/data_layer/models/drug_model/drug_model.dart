// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Drug {
  final String name;
  final String? quantity;
  final String? dosageFrequency;
  final String? dosageTime;
  final Map<String, dynamic>? duration;
  Drug({
    required this.name,
    this.quantity,
    this.dosageFrequency,
    this.dosageTime,
    this.duration,
  });

  Drug copyWith({
    String? name,
    String? quantity,
    String? dosageFrequency,
    String? dosageTime,
    Map<String, dynamic>? duration,
  }) {
    return Drug(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      dosageFrequency: dosageFrequency ?? this.dosageFrequency,
      dosageTime: dosageTime ?? this.dosageTime,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'drugName': name,
      'dosage': quantity,
      'frequency': dosageFrequency,
      'isBeforeMeal': dosageTime == "Before Meal" ? true : false,
      'duration': duration,
    };
  }

  factory Drug.fromMap(Map<String, dynamic> map) {
    return Drug(
      name: () {
        if (map['drugName'] != null) {
          return map['drugName'] as String;
        } else if (map['name'] != null) {
          //for freq searched drugs
          return map['name'] as String;
        } else {
          return '';
        }
      }(),
      quantity: map['dosage'] != null ? map['dosage'] as String : null,
      dosageFrequency: map['frequency'] != null ? map['frequency'] as String : null,
      dosageTime: () {
        if (map['isBeforeMeal'] != null) {
          if (map['isBeforeMeal'] == true) {
            return 'Before Meal';
          } else {
            return 'After Meal';
          }
        } else {
          return null;
        }
      }(),
      duration: map['duration'] != null ? map['duration'] as Map<String, dynamic> : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Drug.fromJson(String source) => Drug.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Drug(name: $name,  quantity: $quantity, dosageFrequency: $dosageFrequency, dosageTime: $dosageTime, duration: $duration)';
  }

  @override
  bool operator ==(covariant Drug other) {
    if (identical(this, other)) return true;
    return other.name == name;
  }

  @override
  int get hashCode {
    return name.hashCode;
  }
}
