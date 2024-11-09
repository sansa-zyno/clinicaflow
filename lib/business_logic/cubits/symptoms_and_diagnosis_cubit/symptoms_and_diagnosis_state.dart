// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'symptoms_and_diagnosis_cubit.dart';

class SymptomsAndDiagnosisState {
  final SymptomsAndDiagnosisStates state;
  final String? message;
  final List<Symptom>? frequentlySearchedSymptoms;
  final List<Symptom>? associatedSymptoms;
  final List<Symptom>? differentialDiagnosis;
  final List<Symptom>? savedSymptoms;
  final List<Symptom>? savedDiagnosis;
  final AppError? error;
  SymptomsAndDiagnosisState({
    required this.state,
    this.message,
    this.frequentlySearchedSymptoms,
    this.associatedSymptoms,
    this.differentialDiagnosis,
    this.savedSymptoms,
    this.savedDiagnosis,
    this.error,
  });

  SymptomsAndDiagnosisState copyWith({
    SymptomsAndDiagnosisStates? state,
    String? message,
    List<Symptom>? frequentlySearchedSymptoms,
    List<Symptom>? associatedSymptoms,
    List<Symptom>? differentialDiagnosis,
    List<Symptom>? savedSymptoms,
    List<Symptom>? savedDiagnosis,
    AppError? error,
  }) {
    return SymptomsAndDiagnosisState(
      state: state ?? this.state,
      message: message ?? this.message,
      frequentlySearchedSymptoms: frequentlySearchedSymptoms ?? this.frequentlySearchedSymptoms,
      associatedSymptoms: associatedSymptoms ?? this.associatedSymptoms,
      differentialDiagnosis: differentialDiagnosis ?? this.differentialDiagnosis,
      savedSymptoms: savedSymptoms,
      savedDiagnosis: savedDiagnosis,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'SymptomsAndDiagnosisState(state: $state, message: $message, frequentlySearchedSymptoms: $frequentlySearchedSymptoms, associatedSymptoms: $associatedSymptoms, differentialDiagnosis: $differentialDiagnosis, error: $error)';
  }
}
