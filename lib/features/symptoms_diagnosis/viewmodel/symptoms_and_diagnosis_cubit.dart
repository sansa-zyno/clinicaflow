import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/core/utils/helper_models/error_model.dart';
import 'package:clinica_flow/features/symptoms_diagnosis/model/diagnosis.dart';
import 'package:clinica_flow/features/symptoms_diagnosis/model/symptom.dart';
import 'package:clinica_flow/features/symptoms_diagnosis/service/symptom_and_diagnosis_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';
part '../state/symptoms_and_diagnosis_state.dart';

class SymptomsAndDiagnosisCubit extends Cubit<SymptomsAndDiagnosisState> {
  SymptomsAndDiagnosisCubit()
      : super(SymptomsAndDiagnosisState(
            state: SymptomsAndDiagnosisStates.initial));

  SymptomAndDiagnosisService service = SymptomAndDiagnosisService();

  Future<void> fetchFrequentlySearchedSymptoms() async {
    emit(state.copyWith(
        state: SymptomsAndDiagnosisStates.fetchingFrequentlySearchedSymptoms,
        savedSymptoms: state.savedSymptoms,
        savedDiagnosis: state.savedDiagnosis));

    try {
      List<Symptom> symptoms = await service.getFrequentlySearchedSymptoms();

      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates.frequentlySearchedSymptomsFetched,
          frequentlySearchedSymptoms: symptoms,
          savedSymptoms: state.savedSymptoms,
          savedDiagnosis: state.savedDiagnosis));
    } catch (error) {
      log('Failed to load symptoms: $error');

      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates.frequentlySearchedSymptomsFailed,
          savedSymptoms: state.savedSymptoms,
          savedDiagnosis: state.savedDiagnosis));
    }
  }

  ddxPredictions(
      List<String> selectedSymptoms, List<String> selectedDiagnosis) async {
    emit(state.copyWith(
        state: SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddx,
        savedSymptoms: state.savedSymptoms,
        savedDiagnosis: state.savedDiagnosis));
    try {
      List<Diagnosis> diagnosis =
          await service.ddxPredictions(selectedSymptoms, selectedDiagnosis);
      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates.symptomAndPredictionForddxFetched,
          differentialDiagnosis: diagnosis,
          savedSymptoms: state.savedSymptoms,
          savedDiagnosis: state.savedDiagnosis));
    } catch (error) {
      log('Failed to load ddxPredictions: $error');
      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates
              .fetchingSymptomAndPredictionForddxFailed,
          savedSymptoms: state.savedSymptoms,
          savedDiagnosis: state.savedDiagnosis));
    }
  }

  postSymptomsAndDiagnosis({
    required String patientId,
    required String appointmentId,
    required List<Map<String, dynamic>> symptoms,
    required List<Map<String, dynamic>> diagnosis,
  }) async {
    emit(state.copyWith(
        state: SymptomsAndDiagnosisStates.postingSymptomsAndDiagnosis,
        savedSymptoms: state.savedSymptoms,
        savedDiagnosis: state.savedDiagnosis));
    try {
      String message = await service.postSymtomsAndDiagnostics(
          patientId: patientId,
          appointmentId: appointmentId,
          symptoms: symptoms,
          diagnosis: diagnosis);
      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates.symptomsAndDiagnosisPosted,
          message: message,
          savedSymptoms: state.savedSymptoms,
          savedDiagnosis: state.savedDiagnosis));
    } catch (error) {
      log('Failed to post ddxPredictions: $error');
      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates.postingSymptomsAndDiagnosisFailed,
          savedSymptoms: state.savedSymptoms,
          savedDiagnosis: state.savedDiagnosis));
    }
  }

  getSavedSymptomsAndDiagnosis({required String appointmentId}) async {
    emit(state.copyWith(
      state: SymptomsAndDiagnosisStates.fetchingSavedSymptomsAndDiagnosis,
    ));
    try {
      Map<String, List<Symptom>?> result = await service
          .getSavedSymptomsAndDiagnosis(appointmentId: appointmentId);
      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates.savedSymptomsAndDiagnosisFetched,
          savedSymptoms: result['symptoms'],
          savedDiagnosis: result['diagnosis']));
    } catch (error) {
      log('Failed to fetch saved symptoms and diagnosis: $error');
      emit(state.copyWith(
        state: SymptomsAndDiagnosisStates.savedSymptomsAndDiagnosisFailed,
      ));
    }
  }
}
