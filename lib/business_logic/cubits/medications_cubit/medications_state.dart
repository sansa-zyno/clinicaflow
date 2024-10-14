// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'medications_cubit.dart';

class MedicationState {
  final MedicationStates state;

  CreateMedications? createMedications;
  List<String>? selectedDiagnoses; // = [];
  int nMedications; // = 0;
  String? errorMessage;
  CreateMedications? medicationResponse;
  List<Drug>? searchedMedications;

  MedicationState({
    required this.state,
    this.createMedications,
    this.selectedDiagnoses,
    this.nMedications = 0,
    this.errorMessage,
    this.medicationResponse,
    this.searchedMedications,
  });

  MedicationState copyWith({
    MedicationStates? state,
    CreateMedications? createMedications,
    List<String>? selectedDiagnoses,
    int? nMedications,
    String? errorMessage,
    CreateMedications? medicationResponse,
    List<Drug>? searchedMedications,
  }) {
    return MedicationState(
        state: state ?? this.state,
        createMedications: createMedications ?? this.createMedications,
        selectedDiagnoses: selectedDiagnoses ?? this.selectedDiagnoses,
        nMedications: nMedications ?? this.nMedications,
        errorMessage: this.errorMessage,
        medicationResponse: medicationResponse ?? this.medicationResponse,
        searchedMedications: searchedMedications ?? this.searchedMedications);
  }
}
