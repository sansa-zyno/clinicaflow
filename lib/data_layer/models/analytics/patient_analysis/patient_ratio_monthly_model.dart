class PatientRatioMonthlyModel {
  PatientRatioMonthlyModel({
    required this.month,
    required this.year,
    required this.newPatients,
    required this.repeatedPatients,
  });

  final String? month;
  final int? year;
  final int? newPatients;
  final int? repeatedPatients;

  PatientRatioMonthlyModel copyWith({
    String? month,
    int? year,
    int? newPatients,
    int? repeatedPatients,
  }) {
    return PatientRatioMonthlyModel(
      month: month ?? this.month,
      year: year ?? this.year,
      newPatients: newPatients ?? this.newPatients,
      repeatedPatients: repeatedPatients ?? this.repeatedPatients,
    );
  }

  factory PatientRatioMonthlyModel.fromJson(Map<String, dynamic> json) {
    return PatientRatioMonthlyModel(
      month: json["month"],
      year: json["year"],
      newPatients: json["newPatients"],
      repeatedPatients: json["repeatedPatients"],
    );
  }

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
        "newPatients": newPatients,
        "repeatedPatients": repeatedPatients,
      };

  @override
  String toString() {
    return "$month, $year, $newPatients, $repeatedPatients, ";
  }
}
