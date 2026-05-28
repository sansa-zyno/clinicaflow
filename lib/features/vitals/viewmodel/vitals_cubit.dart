import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/core/utils/helper_models/error_model.dart';
import 'package:clinica_flow/features/vitals/model/vital.dart';
import 'package:clinica_flow/features/vitals/service/vitals_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
part '../state/vitals_state.dart';

class VitalsCubit extends Cubit<VitalsState> {
  VitalsCubit() : super(VitalsState(state: VitalsStates.initial));

  VitalsService service = VitalsService();

  //? ADD VITAL
  postVitals({
    required String patientId,
    required String appointmentId,
    required Map<String, dynamic> map,
  }) async {
    emit(state.copyWith(
        state: VitalsStates.postingVitals, savedVital: state.savedVital));
    try {
      await service.postVitals(
        patientId: patientId,
        appointmentId: appointmentId,
        map: map,
      );
      emit(state.copyWith(
          state: VitalsStates.vitalsPosted, savedVital: state.savedVital));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          state: VitalsStates.postingVitalsFailed,
          savedVital: state.savedVital));
    }
  }

  //? FETCH VITAL
  getSavedVitals(
      {required String appointmentId, required String patientId}) async {
    emit(state.copyWith(state: VitalsStates.fetchingVitals));
    try {
      Vital savedVital = await service.getVitals(
          appointmentId: appointmentId, patientId: patientId);
      emit(state.copyWith(
          state: VitalsStates.vitalsFetched, savedVital: savedVital));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(state: VitalsStates.fetchingVitalsFailed));
    }
  }

  //? UPDATE VITAL

  //? DELETE VITAL
}
