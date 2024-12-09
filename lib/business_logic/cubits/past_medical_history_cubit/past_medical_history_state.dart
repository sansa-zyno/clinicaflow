part of 'past_medical_history_cubit.dart';

class PastMedicalHistoryState {
  final PastMedicalHistoryStates state;
  final List<HistoryItem>? pastHistory;
  final List<HistoryItem>? familyHistory;
  final List<HistoryItem>? pastProcedureHistory;
  final List<HistoryItem>? allergies;
  final List<HistoryItem>? medication;

  PastMedicalHistoryState({
    required this.state,
    this.pastHistory,
    this.familyHistory,
    this.pastProcedureHistory,
    this.allergies,
    this.medication,
  });

  PastMedicalHistoryState copyWith({
    PastMedicalHistoryStates? state,
    List<HistoryItem>? pastHistory,
    List<HistoryItem>? familyHistory,
    List<HistoryItem>? pastProcedureHistory,
    List<HistoryItem>? allergies,
    List<HistoryItem>? medication,
  }) {
    return PastMedicalHistoryState(
        state: state ?? this.state,
        pastHistory: pastHistory,
        familyHistory: familyHistory,
        pastProcedureHistory: pastProcedureHistory,
        allergies: allergies,
        medication: medication);
  }
}
