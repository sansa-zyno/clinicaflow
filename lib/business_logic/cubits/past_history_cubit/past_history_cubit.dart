import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/past_history/past_history.dart';
import 'package:healtether_clinic_app/data_layer/models/past_history/past_history_response.dart';
import 'package:healtether_clinic_app/data_layer/services/past_history_service/past_history_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'past_history_state.dart';

class PastHistoryCubit extends Cubit<PastHistoryState> {
  PastHistoryCubit()
      : super(PastHistoryState(state: PastHistoryStates.initial));

  PastHistoryService service = PastHistoryService();

  //* PRIVATE HELPER METHODS

  Future<void> _makeRequest({
    Map<String, dynamic>? body,
    required String endpoint,
    required PastHistoryStates loadingState,
    required PastHistoryStates successState,
    required PastHistoryStates failedState,
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
    PastHistoryStates failedState,
    PastHistoryStates successState,
  ) {
    PastHistoryStates? newState;

    log("RESPONSE IS..: $response");

    if (response is AppError) {
      newState = failedState;
    } else {
      newState = response.success ? successState : failedState;
    }

    Set<PastHistory> pastHistories = state.pastHistories?.toSet() ?? {};

    if (response is PastHistoryResponse) {
      log(response.pastHistories?.length);
      pastHistories.addAll(response.pastHistories ?? {});
      log("IDS: ${response.pastHistories?.map((e) => e.id)}");
    }

    log("Is AppError? ${response is AppError}");

    emit(PastHistoryState(
        state: newState,
        message: response is PastHistoryResponse ? response.message : null,
        pastHistory: response is PastHistoryResponse
            ? response.pastHistory ?? state.pastHistory
            : state.pastHistory,
        pastHistories: pastHistories.toList(),
        error: response is AppError ? response : null));

    log("NEW STATE IS: $state");
  }

  //* PUBLIC SIMPLIFIED API ENDPOINTS

  //? CREATE HISTORY
  void createHistory(Map<String, dynamic> body) {
    _makeRequest(
        body: body,
        endpoint: 'api/prescription/past-history',
        method: 'POST',
        loadingState: PastHistoryStates.creatingHistory,
        successState: PastHistoryStates.historyCreated,
        failedState: PastHistoryStates.creatingHistoryFailed);
  }

  //? FETCH HISTORY
  void fetchHistory(String clinicId, {String? appointmentId}) {
    _makeRequest(
        body: {},
        endpoint: 'api/prescription/past-history?clinic_id=$clinicId&appointment_id=$appointmentId',
        method: 'GET',
        loadingState: PastHistoryStates.fetchingHistory,
        successState: PastHistoryStates.historyFetched,
        failedState: PastHistoryStates.fetchingHistoryFailed);
  }

  //? UPDATE HISTORY
  void updateHistory(String historyId, Map<String, dynamic> body) {
    _makeRequest(
        body: body,
        endpoint: 'api/prescription/past-history/$historyId',
        method: 'PATCH',
        loadingState: PastHistoryStates.updatingHistory,
        successState: PastHistoryStates.historyUpdated,
        failedState: PastHistoryStates.updatingHistoryFailed);
  }

  //? DELETE HISTORY
  void deleteHistory(String historyId) {
    _makeRequest(
        body: {},
        endpoint: 'api/prescription/past-history/$historyId',
        method: 'DELETE',
        loadingState: PastHistoryStates.deletingHistory,
        successState: PastHistoryStates.historyDeleted,
        failedState: PastHistoryStates.deletingHistoryFailed);
  }
}
