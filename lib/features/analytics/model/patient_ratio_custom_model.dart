class PatientRatioCustomModel {
  PatientRatioCustomModel({
    required this.newPatients,
    required this.repeatedPatients,
    required this.date,
  });

  final int? newPatients;
  final int? repeatedPatients;
  final dynamic date;

  PatientRatioCustomModel copyWith({
    int? newPatients,
    int? repeatedPatients,
    dynamic date,
  }) {
    return PatientRatioCustomModel(
      newPatients: newPatients ?? this.newPatients,
      repeatedPatients: repeatedPatients ?? this.repeatedPatients,
      date: date ?? this.date,
    );
  }

  factory PatientRatioCustomModel.fromJson(Map<String, dynamic> json) {
    return PatientRatioCustomModel(
      newPatients: json["newPatients"],
      repeatedPatients: json["repeatedPatients"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() => {
        "newPatients": newPatients,
        "repeatedPatients": repeatedPatients,
        "date": date,
      };

  @override
  String toString() {
    return "$newPatients, $repeatedPatients, $date, ";
  }
}
