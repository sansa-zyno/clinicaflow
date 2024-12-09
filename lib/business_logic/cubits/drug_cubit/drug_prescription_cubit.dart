import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/services/drug_prescription_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
part 'drug_prescription_state.dart';

class DrugPrescriptionCubit extends Cubit<DrugPrescriptionState> {
  DrugPrescriptionCubit() : super(DrugPrescriptionState(state: DrugPrescriptionStates.initial));

  DrugPrescriptionService service = DrugPrescriptionService();

  void fetchFrequentlySearchedDrugs() async {
    emit(state.copyWith(state: DrugPrescriptionStates.fetchingFrequentlySearchedDrugs, savedDrugPrescription: state.savedDrugPrescription));

    try {
      List<Drug> drugs = await service.getFrequentlySearchedDrugs();

      emit(state.copyWith(
          state: DrugPrescriptionStates.frequentlySearchedDrugsFetched,
          frequentlySearchedDrugs: drugs,
          savedDrugPrescription: state.savedDrugPrescription));
    } catch (error) {
      log('Failed to load drugs: $error');
      emit(state.copyWith(state: DrugPrescriptionStates.frequentlySearchedDrugsFailed, savedDrugPrescription: state.savedDrugPrescription));
    }
  }

  Future<void> searchDrugs(String query) async {
    emit(state.copyWith(state: DrugPrescriptionStates.searchingForDrugs, savedDrugPrescription: state.savedDrugPrescription));
    try {
      final drugs = await service.searchDrugs(query);
      emit(state.copyWith(state: DrugPrescriptionStates.searchingForDrugsSuccess, drugs: drugs, savedDrugPrescription: state.savedDrugPrescription));
    } catch (e) {
      emit(state.copyWith(state: DrugPrescriptionStates.searchingForDrugsFailed, savedDrugPrescription: state.savedDrugPrescription));
    }
  }

  postDrugPrescription({
    required String patientId,
    required String appointmentId,
    required List<Map<String, dynamic>> drugs,
    required String patientAdvice,
    required String privateNotes,
    required String followupDate,
    required String followupTimeSlot,
  }) async {
    emit(state.copyWith(state: DrugPrescriptionStates.postingDrugPrescription, savedDrugPrescription: state.savedDrugPrescription));
    try {
      String message = await service.postDrugPrescription(
        patientId: patientId,
        appointmentId: appointmentId,
        drugs: drugs,
        patientAdvice: patientAdvice,
        privateNotes: privateNotes,
        followupDate: followupDate,
        followupTimeSlot: followupTimeSlot,
      );
      emit(state.copyWith(state: DrugPrescriptionStates.drugPrescriptionPosted, savedDrugPrescription: state.savedDrugPrescription));
    } catch (error) {
      log('Failed to save drug Prescriptions: $error');
      emit(state.copyWith(state: DrugPrescriptionStates.postingDrugPrescriptionFailed, savedDrugPrescription: state.savedDrugPrescription));
    }
  }

  getSavedDrugPrescription({required String appointmentId}) async {
    emit(state.copyWith(state: DrugPrescriptionStates.fetchingSavedDrugPrescription));
    try {
      Map<String, dynamic>? result = await service.getSavedDrugPrescription(appointmentId: appointmentId);
      emit(state.copyWith(
        state: DrugPrescriptionStates.savedDrugPrescriptionFetched,
        savedDrugPrescription: result,
      ));
    } catch (error) {
      log('Failed to fetch saved Drugs: $error');
      emit(state.copyWith(state: DrugPrescriptionStates.savedDrugPrescriptionFailed));
    }
  }
}
