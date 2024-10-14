import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vitals_response.dart';
import 'package:healtether_clinic_app/data_layer/services/vitals_service/vitals_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'vitals_state.dart';

class VitalsCubit extends Cubit<VitalsState> {
  VitalsCubit() : super(VitalsState(state: VitalsStates.initial));

  VitalsService service = VitalsService();

  //* PRIVATE HELPER METHODS

  Future<void> _makeRequest({
    Map<String, dynamic>? body,
    required String endpoint,
    required VitalsStates loadingState,
    required VitalsStates successState,
    required VitalsStates failedState,
    String method = 'POST',
  }) async {
    // emit loading state
    emit(state.copyWith(state: loadingState));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';

    final response = await service.makeRequest(
      endpoint: endpoint,
      body: body,
      token: token,
      method: method,
    );

    _setState(response, failedState, successState);
  }

  void _setState(
    dynamic response,
    VitalsStates failedState,
    VitalsStates successState,
  ) {
    VitalsStates? newState;

    log("RESPONSE IS..: $response");

    if (response is AppError) {
      newState = failedState;
    } else {
      newState = response.success ? successState : failedState;
    }

    Set<Vital> vitals = state.vitals?.toSet() ?? {};

    if (response is VitalsResponse) {
      vitals.addAll(response.vitals ?? {});
    }

    log("Is AppError? ${response is AppError}");

    emit(VitalsState(
        state: newState,
        message: response is VitalsResponse ? response.message : null,
        vitals: vitals.toList(),
        error: response is AppError ? response : null));

    log("NEW STATE IS: $state");
  }

  //* PUBLIC SIMPLIFIED API ENDPOINTS

  //? ADD VITAL
  void addVital(Map<String, dynamic> body) {
    _makeRequest(
        body: body,
        endpoint: 'api/prescription/vitals',
        method: 'POST',
        loadingState: VitalsStates.addingVital,
        successState: VitalsStates.vitalAdded,
        failedState: VitalsStates.addingVitalFailed);
  }

  //? FETCH VITAL
  void fetchVitals({String? appointmentId}) {
    _makeRequest(
        body: {},
        endpoint: 'api/prescription/vitals?${appointmentId != null ? "appointment_id=$appointmentId" : ""}',
        method: 'GET',
        loadingState: VitalsStates.fetchingVitals,
        successState: VitalsStates.vitalsFetched,
        failedState: VitalsStates.fetchingVitalsFailed);
  }

  //? UPDATE VITAL
  void updateVital(String vitalId, Map<String, dynamic> body) {
    _makeRequest(
        body: body,
        endpoint: 'api/prescription/vitals/$vitalId',
        method: 'PATCH',
        loadingState: VitalsStates.updatingVital,
        successState: VitalsStates.vitalUpdated,
        failedState: VitalsStates.updatingVitalFailed);
  }

  //? DELETE VITAL
  void deleteVital(String vitalId) {
    _makeRequest(
        body: {},
        endpoint: 'api/prescription/vitals/$vitalId',
        method: 'DELETE',
        loadingState: VitalsStates.deletingVital,
        successState: VitalsStates.vitalDeleted,
        failedState: VitalsStates.deletingVitalFailed);
  }
}
