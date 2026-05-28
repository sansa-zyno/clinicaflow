class PatientGenderRatioMonthlyModel {
  PatientGenderRatioMonthlyModel({
    required this.id,
    required this.total,
    required this.gender,
    required this.genderCount,
    required this.percentage,
  });

  final dynamic id;
  final int? total;
  final String? gender;
  final int genderCount;
  final int percentage;

  PatientGenderRatioMonthlyModel copyWith({
    dynamic id,
    int? total,
    String? gender,
    int? genderCount,
    int? percentage,
  }) {
    return PatientGenderRatioMonthlyModel(
      id: id ?? this.id,
      total: total ?? this.total,
      gender: gender ?? this.gender,
      genderCount: genderCount ?? this.genderCount,
      percentage: percentage ?? this.percentage,
    );
  }

  factory PatientGenderRatioMonthlyModel.fromJson(Map<String, dynamic> json) {
    return PatientGenderRatioMonthlyModel(
      id: json["_id"],
      total: json["total"],
      gender: json["gender"],
      genderCount: json["genderCount"],
      percentage: json["percentage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "total": total,
        "gender": gender,
        "genderCount": genderCount,
        "percentage": percentage,
      };

  @override
  String toString() {
    return "$id, $total, $gender, $genderCount, $percentage, ";
  }
}
