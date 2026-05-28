import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/past_medical_history/model/history_item.dart';
import 'package:clinica_flow/features/past_medical_history/service/past_medical_history_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
part '../state/past_medical_history_state.dart';

class PastMedicalHistoryCubit extends Cubit<PastMedicalHistoryState> {
  PastMedicalHistoryCubit()
      : super(PastMedicalHistoryState(state: PastMedicalHistoryStates.initial));

  PastMedicalHistoryService service = PastMedicalHistoryService();

  postPastMedicalHistory(
      {required String patientId,
      required List<Map<String, dynamic>> medication,
      required List<Map<String, dynamic>> allergies,
      required List<Map<String, dynamic>> familyHistory,
      required List<Map<String, dynamic>> pastHistory,
      required List<Map<String, dynamic>> pastProcedureHistory}) async {
    emit(state.copyWith(
        state: PastMedicalHistoryStates.postingPastMedicalHistory,
        allergies: state.allergies,
        medication: state.medication,
        familyHistory: state.familyHistory,
        pastHistory: state.pastHistory,
        pastProcedureHistory: state.pastProcedureHistory));
    try {
      await service.postPastMedicalHistory(
          patientId: patientId,
          medication: medication,
          allergies: allergies,
          familyHistory: familyHistory,
          pastHistory: pastHistory,
          pastProcedureHistory: pastProcedureHistory);
      emit(state.copyWith(
          state: PastMedicalHistoryStates.pastMedicalHistoryPosted,
          allergies: state.allergies,
          medication: state.medication,
          familyHistory: state.familyHistory,
          pastHistory: state.pastHistory,
          pastProcedureHistory: state.pastProcedureHistory));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          state: PastMedicalHistoryStates.postingPastMedicalHistoryFailed,
          allergies: state.allergies,
          medication: state.medication,
          familyHistory: state.familyHistory,
          pastHistory: state.pastHistory,
          pastProcedureHistory: state.pastProcedureHistory));
    }
  }

  getPastMedicalHistory({required String patientId}) async {
    emit(state.copyWith(
        state: PastMedicalHistoryStates.fetchingPastMedicalHistory));
    try {
      Map<String, List<HistoryItem>?> result =
          await service.getPastMedicalHistory(patientId: patientId);
      emit(state.copyWith(
          state: PastMedicalHistoryStates.pastMedicalHistoryFetched,
          allergies: result['allergies'],
          medication: result['medication'],
          familyHistory: result['familyHistory'],
          pastHistory: result['pastHistory'],
          pastProcedureHistory: result['pastProcedureHistory']));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          state: PastMedicalHistoryStates.fetchingPastMedicalHistoryFailed));
    }
  }
}
