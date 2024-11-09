part of 'past_medical_history_cubit.dart';

class PastMedicalHistoryState {
  final PastMedicalHistoryStates state;
  final List<HistoryItem>? pastHistory;
  final List<HistoryItem>? familyHistory;
  final List<HistoryItem>? pastProcedures;
  final List<HistoryItem>? allergies;
  final List<HistoryItem>? medicationHistory;

  PastMedicalHistoryState({
    required this.state,
    this.pastHistory,
    this.familyHistory,
    this.pastProcedures,
    this.allergies,
    this.medicationHistory,
  });

  PastMedicalHistoryState copyWith({
    PastMedicalHistoryStates? state,
    List<HistoryItem>? pastHistory,
    List<HistoryItem>? familyHistory,
    List<HistoryItem>? pastProcedures,
    List<HistoryItem>? allergies,
    List<HistoryItem>? medicationHistory,
  }) {
    return PastMedicalHistoryState(
        state: state ?? this.state,
        pastHistory: pastHistory,
        familyHistory: familyHistory,
        pastProcedures: pastProcedures,
        allergies: allergies,
        medicationHistory: medicationHistory);
  }
}
