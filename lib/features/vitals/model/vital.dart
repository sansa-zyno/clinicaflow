import 'dart:convert';

import 'package:uuid/uuid.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Vital {
  final String? id;
  final String? appointment;
  final int? spo2;
  final int? temperature;
  final int? height;
  final int? weight;
  final int? pulseRate;
  final int? rbs;
  final int? respiratoryRate;
  final BloodPressure? bloodPressure;
  final Set<PersonalHistory>? personalHistories;

  Vital({
    this.id,
    this.appointment,
    this.spo2,
    this.temperature,
    this.height,
    this.weight,
    this.pulseRate,
    this.rbs,
    this.respiratoryRate,
    this.bloodPressure,
    this.personalHistories,
  });

  @override
  String toString() {
    return 'Vital( id: $id,appointment: $appointment  spo2: $spo2 temperature: $temperature height: $height weight: $weight pulseRate: $pulseRate rbs: $rbs respiratoryRate: $respiratoryRate,bloodPressure: $bloodPressure,personalHistory: $personalHistories)';
  }

  Vital copyWith({
    int? spo2,
    int? temperature,
    int? height,
    int? weight,
    int? pulseRate,
    int? rbs,
    int? respiratoryRate,
    BloodPressure? bloodPressure,
    Set<PersonalHistory>? personalHistories,
  }) {
    return Vital(
      spo2: spo2 ?? this.spo2,
      temperature: temperature ?? this.temperature,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      pulseRate: pulseRate ?? this.pulseRate,
      rbs: rbs ?? this.rbs,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      personalHistories: personalHistories ?? this.personalHistories,
    );
  }

  /*
 "vitals": {
    "bloodPressure": {
      "systolic": 120,
      "diastolic": 80
    },
    "_id": "6741f68840e7b037fce50d68",
    "spo2": 98,
    "temperature": 37,
    "height": 170,
    "weight": 65,
    "pulseRate": 75,
    "rbs": 90,
    "respiratoryRate": 18,
    "appointment": "6741f65e40e7b037fce50d3f"
  },*/
  factory Vital.fromMapWithPersonalHistory(Map<String, dynamic> map) {
    final vital = Vital(
        id: map['vitals']?['id'] != null ? map['vitals']['id'] as String : null,
        appointment: map['vitals']?['appointment'] != null
            ? map['vitals']['appointment'] as String
            : null,
        spo2: map['vitals']?['spo2'] != null
            ? map['vitals']['spo2'] as int
            : null,
        temperature: map['vitals']?['temperature'] != null
            ? map['vitals']['temperature'] as int
            : null,
        height: map['vitals']?['height'] != null
            ? map['vitals']['height'] as int
            : null,
        weight: map['vitals']?['weight'] != null
            ? map['vitals']['weight'] as int
            : null,
        pulseRate: map['vitals']?['pulseRate'] != null
            ? map['vitals']['pulseRate'] as int
            : null,
        rbs: map['vitals']?['rbs'] != null ? map['vitals']['rbs'] as int : null,
        respiratoryRate: map['vitals']?['respiratoryRate'] != null
            ? map['vitals']['respiratoryRate'] as int
            : null,
        bloodPressure: map['vitals']?['bloodPressure'] != null
            ? BloodPressure.fromMap(
                map['vitals']['bloodPressure'] as Map<String, dynamic>)
            : null,
        personalHistories: map['personalHistory'] != null
            ? (map['personalHistory'] as List)
                .map((e) => PersonalHistory.fromMap(e))
                .toSet()
            : null);
    return vital;
  }

  factory Vital.fromMap(Map<String, dynamic> map) {
    final vital = Vital(
        id: map['id'] != null ? map['id'] as String : null,
        appointment:
            map['appointment'] != null ? map['appointment'] as String : null,
        spo2: map['spo2'] != null ? map['spo2'] as int : null,
        temperature:
            map['temperature'] != null ? map['temperature'] as int : null,
        height: map['height'] != null ? map['height'] as int : null,
        weight: map['weight'] != null ? map['weight'] as int : null,
        pulseRate: map['pulseRate'] != null ? map['pulseRate'] as int : null,
        rbs: map['rbs'] != null ? map['rbs'] as int : null,
        respiratoryRate: map['respiratoryRate'] != null
            ? map['respiratoryRate'] as int
            : null,
        bloodPressure: map['bloodPressure'] != null
            ? BloodPressure.fromMap(
                map['bloodPressure'] as Map<String, dynamic>)
            : null,
        personalHistories: map['personalHistory'] != null
            ? (map['personalHistory'] as List)
                .map((e) => PersonalHistory.fromMap(e))
                .toSet()
            : null);
    return vital;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vitals': {
        "id": id ?? const Uuid().v4(),
        "bloodPressure": bloodPressure != null
            ? bloodPressure!.toMap()
            : BloodPressure().toMap(),
        "spo2": spo2 ?? "",
        "temperature": temperature ?? "",
        "height": height ?? "",
        "weight": weight ?? "",
        "pulseRate": pulseRate ?? "",
        "rbs": rbs ?? "",
        "respiratoryRate": respiratoryRate ?? "",
      },
      'personalHistories': personalHistories != null
          ? personalHistories!.map((e) => e.toMap()).toList()
          : [],
    };
  }

  // String toJson() => json.encode(toMap());

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

class BloodPressure {
  final int? systolic;
  final int? diastolic;

  BloodPressure({this.systolic, this.diastolic});

  BloodPressure copyWith({
    int? systolic,
    int? diastolic,
  }) {
    return BloodPressure(
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
    );
  }

  factory BloodPressure.fromMap(Map<String, dynamic> map) {
    return BloodPressure(
      systolic: map['systolic'] != null ? map['systolic'] as int : null,
      diastolic: map['diastolic'] != null ? map['diastolic'] as int : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "systolic": systolic ?? "",
      "diastolic": diastolic ?? "",
    };
  }
}

class PersonalHistory {
  final String activity;
  final String? nature;
  final String? privateNote;

  PersonalHistory({required this.activity, this.nature, this.privateNote});

  PersonalHistory copyWith({
    String? activity,
    String? nature,
    String? privateNote,
  }) {
    return PersonalHistory(
      activity: activity ?? this.activity,
      nature: nature ?? this.nature,
      privateNote: privateNote ?? this.privateNote,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activity': activity,
      "nature": nature ?? "",
      'notes': privateNote ?? "",
    };
  }

  factory PersonalHistory.fromMap(Map<String, dynamic> map) {
    return PersonalHistory(
        activity: map['activity'] ?? '',
        nature: map['nature'] ?? '',
        privateNote: map['notes'] ?? '');
  }

  PersonalHistory clear() {
    return PersonalHistory(activity: activity);
  }

  @override
  bool operator ==(covariant PersonalHistory other) {
    if (identical(this, other)) return true;
    return other.activity == activity;
  }

  @override
  int get hashCode {
    return activity.hashCode;
  }
}
