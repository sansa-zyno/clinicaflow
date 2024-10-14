class PatientGenderRatioCustomModel {
  PatientGenderRatioCustomModel({
    required this.gender,
    required this.genderCount,
    required this.percentage,
  });

  final String? gender;
  final int? genderCount;
  final int? percentage;

  PatientGenderRatioCustomModel copyWith({
    String? gender,
    int? genderCount,
    int? percentage,
  }) {
    return PatientGenderRatioCustomModel(
      gender: gender ?? this.gender,
      genderCount: genderCount ?? this.genderCount,
      percentage: percentage ?? this.percentage,
    );
  }

  factory PatientGenderRatioCustomModel.fromJson(Map<String, dynamic> json) {
    return PatientGenderRatioCustomModel(
      gender: json["gender"],
      genderCount: json["genderCount"],
      percentage: json["percentage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "genderCount": genderCount,
        "percentage": percentage,
      };

  @override
  String toString() {
    return "$gender, $genderCount, $percentage, ";
  }
}
