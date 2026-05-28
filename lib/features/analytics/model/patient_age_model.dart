class PatientAgeModel {
  PatientAgeModel({
    required this.count,
    required this.ageGroup,
  });

  final int? count;
  final String? ageGroup;

  PatientAgeModel copyWith({
    int? count,
    String? ageGroup,
  }) {
    return PatientAgeModel(
      count: count ?? this.count,
      ageGroup: ageGroup ?? this.ageGroup,
    );
  }

  factory PatientAgeModel.fromJson(Map<String, dynamic> json) {
    return PatientAgeModel(
      count: json["count"],
      ageGroup: json["ageGroup"],
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "ageGroup": ageGroup,
      };

  @override
  String toString() {
    return "$count, $ageGroup, ";
  }
}
