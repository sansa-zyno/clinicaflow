import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/response_models/symptoms_and_diagnoses_response.dart';
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';
import 'package:healtether_clinic_app/data_layer/services/symptom_and_diagnosis_service/symptom_and_diagnosis_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'symptoms_and_diagnosis_state.dart';

class SymptomsAndDiagnosisCubit extends Cubit<SymptomsAndDiagnosisState> {
  SymptomsAndDiagnosisCubit() : super(SymptomsAndDiagnosisState(state: SymptomsAndDiagnosisStates.initial));

  SymptomAndDiagnosisService service = SymptomAndDiagnosisService();

  Future<void> _makeRequest({
    Map<String, dynamic>? body,
    required String endpoint,
    required SymptomsAndDiagnosisStates loadingState,
    required SymptomsAndDiagnosisStates successState,
    required SymptomsAndDiagnosisStates failedState,
    String method = 'POST',
    String? baseUrl,
  }) async {
    // emit loading state
    emit(state.copyWith(state: loadingState));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';

    final response = await service.makeRequest(
      endpoint: endpoint,
      baseUrl: baseUrl,
      body: body,
      token: token,
      method: method,
    );

    _setState(response, failedState, successState);
  }

  void _setState(
    dynamic response,
    SymptomsAndDiagnosisStates failedState,
    SymptomsAndDiagnosisStates successState,
  ) {
    SymptomsAndDiagnosisStates? newState;

    log("RESPONSE IS..: $response");

    if (response is AppError) {
      newState = failedState;
    } else {
      newState = response.success ? successState : failedState;
    }

    log("Is AppError? ${response is AppError}");

    emit(SymptomsAndDiagnosisState(
        state: newState,
        message: response is SymptomsAndDiagnosisResponse ? response.message : null,
        associatedSymptoms: response is SymptomsAndDiagnosisResponse ? response.associatedSymptoms : null,
        differentialDiagnosis: response is SymptomsAndDiagnosisResponse ? response.differentialDiagnosis : null,
        error: response is AppError ? response : null));

    log("NEW STATE IS: $state");
  }

  void searchSymptomAndPredictionForddx(Map<String, dynamic> body) {
    _makeRequest(
        endpoint: 'ddx/predict',
        body: body,
        baseUrl: "https://43.204.120.239:8000",
        loadingState: SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddx,
        successState: SymptomsAndDiagnosisStates.symptomAndPredictionForddxFetched,
        failedState: SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddxFailed);
  }

  Future<void> fetchFrequentlySearchedSymptoms() async {
    emit(state.copyWith(state: SymptomsAndDiagnosisStates.fetchingFrequentlySearchedSymptoms));

    try {
      List<Symptom> symptoms = await service.getFrequentlySearchedSymptoms();

      emit(state.copyWith(state: SymptomsAndDiagnosisStates.frequentlySearchedSymptomsFetched, frequentlySearchedSymptoms: symptoms));
    } catch (error) {
      log('Failed to load symptoms: $error');

      emit(state.copyWith(state: SymptomsAndDiagnosisStates.frequentlySearchedSymptomsFailed));
    }
  }

  ddxPredictions(List selectedSymptoms, List selectedDiagnosis) async {
    emit(state.copyWith(state: SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddx));

    try {
      Map<String, List<Symptom>> ddxPredictions = await service.ddxPredictions(selectedSymptoms, selectedDiagnosis);
      emit(state.copyWith(
          state: SymptomsAndDiagnosisStates.symptomAndPredictionForddxFetched,
          associatedSymptoms: ddxPredictions['Sx'],
          differentialDiagnosis: ddxPredictions['Dx']));
    } catch (error) {
      log('Failed to load ddxPredictions: $error');

      emit(state.copyWith(state: SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddxFailed));
    }
  }

  postSymptomsAndDiagnosis({required String patientId, required String appointmentId, required List symptoms, required List diagnosis}) async {
    emit(state.copyWith(state: SymptomsAndDiagnosisStates.postingSymptomsAndDiagnosis));
    try {
      String message =
          await service.postSymtomsAndDiagnostics(patientId: patientId, appointmentId: appointmentId, symptoms: symptoms, diagnosis: diagnosis);
      emit(state.copyWith(state: SymptomsAndDiagnosisStates.symptomsAndDiagnosisPosted, message: message));
    } catch (error) {
      log('Failed to load ddxPredictions: $error');
      emit(state.copyWith(state: SymptomsAndDiagnosisStates.postingSymptomsAndDiagnosisFailed));
    }
  }

  getSavedSymptomsAndDiagnosis({required String appointmentId}) async {
    emit(state.copyWith(
      state: SymptomsAndDiagnosisStates.fetchingSavedSymptomsAndDiagnosis,
    ));
    try {
      Map<String, List<Symptom>?> result = await service.getSavedSymptomsAndDiagnosis(appointmentId: appointmentId);
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
