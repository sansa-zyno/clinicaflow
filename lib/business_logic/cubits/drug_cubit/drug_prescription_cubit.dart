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
    emit(state.copyWith(state: DrugPrescriptionStates.fetchingFrequentlySearchedDrugs));

    try {
      List<Drug> drugs = await service.getFrequentlySearchedDrugs();

      emit(state.copyWith(state: DrugPrescriptionStates.frequentlySearchedDrugsFetched, frequentlySearchedDrugs: drugs));
    } catch (error) {
      log('Failed to load drugs: $error');
      emit(state.copyWith(state: DrugPrescriptionStates.frequentlySearchedDrugsFailed));
    }
  }

  Future<void> searchDrugs(String query) async {
    emit(state.copyWith(state: DrugPrescriptionStates.searchingForDrugs));
    try {
      final drugs = await service.searchDrugs(query);
      emit(state.copyWith(state: DrugPrescriptionStates.searchingForDrugsSuccess, drugs: drugs));
    } catch (e) {
      emit(state.copyWith(state: DrugPrescriptionStates.searchingForDrugsFailed));
    }
  }

  postDrugPrescription({required String patientId, required String appointmentId, required List drugs}) async {
    emit(state.copyWith(state: DrugPrescriptionStates.postingDrugPrescription));
    try {
      String message = await service.postDrugPrescription(patientId: patientId, appointmentId: appointmentId, drugs: drugs);
      emit(state.copyWith(
        state: DrugPrescriptionStates.drugPrescriptionPosted,
      ));
    } catch (error) {
      log('Failed to save drug Prescriptions: $error');
      emit(state.copyWith(state: DrugPrescriptionStates.postingDrugPrescriptionFailed));
    }
  }

  getSavedDrugPrescription({required String appointmentId}) async {
    emit(state.copyWith(state: DrugPrescriptionStates.fetchingSavedDrugPrescription));
    try {
      List<Drug>? result = await service.getSavedDrugPrescription(appointmentId: appointmentId);
      emit(state.copyWith(
        state: DrugPrescriptionStates.savedDrugPrescriptionFetched,
        savedDrugs: result,
      ));
    } catch (error) {
      log('Failed to fetch saved Drugs: $error');
      emit(state.copyWith(state: DrugPrescriptionStates.savedDrugPrescriptionFailed));
    }
  }
}
