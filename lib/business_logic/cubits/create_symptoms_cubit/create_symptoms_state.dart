// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_symptoms_cubit.dart';

class CreateSymptomsState {
  final CreateSymptomsStates state;
  CreateSymptoms? createSymptoms;
  String? errorMessage;
  List<String>? symptomsList;
  List<String>? diagnosesList;

  CreateSymptomsState({
    required this.state,
    this.createSymptoms,
    this.errorMessage,
    this.symptomsList,
    this.diagnosesList,
  });

  CreateSymptomsState copyWith({
    CreateSymptomsStates? state,
    CreateSymptoms? createSymptoms,
    String? errorMessage,
    List<String>? symptomsList,
    List<String>? diagnosesList,
  }) {
    return CreateSymptomsState(
      state: state ?? this.state,
      createSymptoms: createSymptoms ?? this.createSymptoms,
      errorMessage: errorMessage ?? this.errorMessage,
      symptomsList: symptomsList ?? this.symptomsList,
      diagnosesList: diagnosesList ?? this.diagnosesList,
    );
  }
}
