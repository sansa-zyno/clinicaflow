import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/history_item/history_item.dart';
import 'package:healtether_clinic_app/data_layer/services/past%20medical%20history/past_medical_history_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
part 'past_medical_history_state.dart';

class PastMedicalHistoryCubit extends Cubit<PastMedicalHistoryState> {
  PastMedicalHistoryCubit() : super(PastMedicalHistoryState(state: PastMedicalHistoryStates.initial));

  PastMedicalHistoryService service = PastMedicalHistoryService();

  postPastMedicalHistory(
      {required String patientId,
      required List medications,
      required List allergies,
      required List familyHistory,
      required List pastHistory,
      required List pastProcedureHistory}) async {
    emit(state.copyWith(state: PastMedicalHistoryStates.postingPastMedicalHistory));
    try {
      String message = await service.postPastMedicalHistory(
          patientId: patientId,
          medications: medications,
          allergies: allergies,
          familyHistory: familyHistory,
          pastHistory: pastHistory,
          pastProcedureHistory: pastProcedureHistory);
      emit(state.copyWith(
        state: PastMedicalHistoryStates.pastMedicalHistoryPosted,
      ));
    } catch (error) {
      log('Failed to save past medical history: $error');
      emit(state.copyWith(state: PastMedicalHistoryStates.postingPastMedicalHistoryFailed));
    }
  }
}
