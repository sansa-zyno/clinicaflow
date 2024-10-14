class PatientRatioWeeklyModel {
  PatientRatioWeeklyModel({
    required this.weekday,
    required this.newPatients,
    required this.repeatedPatients,
  });

  final String? weekday;
  final int? newPatients;
  final int? repeatedPatients;

  PatientRatioWeeklyModel copyWith({
    String? weekday,
    int? newPatients,
    int? repeatedPatients,
  }) {
    return PatientRatioWeeklyModel(
      weekday: weekday ?? this.weekday,
      newPatients: newPatients ?? this.newPatients,
      repeatedPatients: repeatedPatients ?? this.repeatedPatients,
    );
  }

  factory PatientRatioWeeklyModel.fromJson(Map<String, dynamic> json) {
    return PatientRatioWeeklyModel(
      weekday: json["weekday"],
      newPatients: json["newPatients"],
      repeatedPatients: json["repeatedPatients"],
    );
  }

  Map<String, dynamic> toJson() => {
        "weekday": weekday,
        "newPatients": newPatients,
        "repeatedPatients": repeatedPatients,
      };

  @override
  String toString() {
    return "$weekday, $newPatients, $repeatedPatients, ";
  }
}
