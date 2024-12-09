import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/data_layer/services/vitals_service/vitals_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
part 'vitals_state.dart';

class VitalsCubit extends Cubit<VitalsState> {
  VitalsCubit() : super(VitalsState(state: VitalsStates.initial));

  VitalsService service = VitalsService();

  //? ADD VITAL
  postVitals({
    required String patientId,
    required String appointmentId,
    required Map<String, dynamic> map,
  }) async {
    emit(state.copyWith(state: VitalsStates.postingVitals, savedVital: state.savedVital));
    try {
      String message = await service.postVitals(
        patientId: patientId,
        appointmentId: appointmentId,
        map: map,
      );
      emit(state.copyWith(state: VitalsStates.vitalsPosted, savedVital: state.savedVital));
    } catch (error) {
      log('Failed to save vitals: $error');
      emit(state.copyWith(state: VitalsStates.postingVitalsFailed, savedVital: state.savedVital));
    }
  }

  //? FETCH VITAL
  getSavedVitals({required String appointmentId}) async {
    emit(state.copyWith(state: VitalsStates.fetchingVitals));
    try {
      Vital savedVital = await service.getVitals(appointmentId: appointmentId);
      emit(state.copyWith(state: VitalsStates.vitalsFetched, savedVital: savedVital));
    } catch (error) {
      log('Failed to load saved vitals: $error');
      emit(state.copyWith(state: VitalsStates.fetchingVitalsFailed));
    }
  }

  //? UPDATE VITAL

  //? DELETE VITAL
}
