class CreateSymptoms {
  String? searchText;
  List<String>? inputSymptoms;
  List<String>? inputDiagnoses;
  int? nDiseases;
  int? nSymptoms;
  int? minSymptoms;

  CreateSymptoms(
      {this.searchText,
      this.inputSymptoms,
      this.inputDiagnoses,
      this.nDiseases,
      this.nSymptoms,
      this.minSymptoms});

  CreateSymptoms.fromJson(Map<String, dynamic> json) {
    searchText = json['search_text'];
    inputSymptoms = json['input_symptoms'].cast<String>();
    inputDiagnoses = json['input_diagnoses'].cast<String>();
    nDiseases = json['n_diseases'];
    nSymptoms = json['n_symptoms'];
    minSymptoms = json['min_symptoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_text'] = searchText;
    data['input_symptoms'] = inputSymptoms;
    data['input_diagnoses'] = inputDiagnoses;
    data['n_diseases'] = nDiseases;
    data['n_symptoms'] = nSymptoms;
    data['min_symptoms'] = minSymptoms;
    return data;
  }
}
