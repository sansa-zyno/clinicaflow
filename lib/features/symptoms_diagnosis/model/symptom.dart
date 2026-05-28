// ignore_for_file: public_member_api_docs, sort_constructors_first
class Symptom {
  final String name;
  final String type; // type can only be: Sx or Dx
  final int? timePeriod;
  final String? timeUnit;
  final String? privateNote;
  Symptom({
    required this.name,
    required this.type,
    this.timePeriod,
    this.timeUnit,
    this.privateNote,
  });

  Symptom copyWith({
    String? name,
    int? timePeriod,
    String? timeUnit,
    String? privateNote,
  }) {
    return Symptom(
      type: type,
      name: name ?? this.name,
      timePeriod: timePeriod ?? this.timePeriod,
      timeUnit: timeUnit ?? this.timeUnit,
      privateNote: privateNote ?? this.privateNote,
    );
  }

  Map<String, dynamic> toSxMap() {
    return <String, dynamic>{
      'name': name,
      'duration': {"value": timePeriod, "unit": timeUnit},
      'notes': privateNote,
    };
  }

  Map<String, dynamic> toDxMap() {
    return <String, dynamic>{
      'name': name,
      'notes': privateNote,
    };
  }

  factory Symptom.fromMap(Map<String, dynamic> map, String type) {
    return Symptom(
      name: map['name'] as String,
      type: type,
      timePeriod: map['duration'] != null ? map['duration']['value'] as int : null,
      timeUnit: map['duration'] != null ? map['duration']['unit'] as String : null,
      privateNote: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  Symptom clear() {
    return Symptom(name: name, type: type);
  }

  @override
  String toString() {
    return 'Symptom(name: $name, timePeriod: $timePeriod, timeUnit: $timeUnit, privateNote: $privateNote)';
  }

  @override
  bool operator ==(covariant Symptom other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode {
    return name.hashCode;
  }
}
