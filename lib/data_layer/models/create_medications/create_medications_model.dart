class CreateMedications {
  List<String>? selectedDiagnoses;
  int? nMedications;

  CreateMedications({this.selectedDiagnoses, this.nMedications});

  // CreateMedications.fromJson(Map<String, dynamic> json) {
  //   selectedDiagnoses = json['selected_diagnoses'].cast<String>();
  //   nMedications = json['n_medications'];
  // }
  factory CreateMedications.fromJson(Map<String, dynamic> json) {
    var diagnosesList = json['selected_diagnoses'];
    List<String>? diagnoses = diagnosesList != null ? List<String>.from(diagnosesList) : null;

    return CreateMedications(
      selectedDiagnoses: diagnoses,
      nMedications: json['n_medications'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selected_diagnoses'] = selectedDiagnoses;
    data['n_medications'] = nMedications;
    return data;
  }
}
