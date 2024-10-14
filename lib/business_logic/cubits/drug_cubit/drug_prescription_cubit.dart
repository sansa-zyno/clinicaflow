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

  void saveDrug({required String patientId, required Drug drug}) {
    final Map<String, List<Drug>> savedDrugs = state.savedDrugs ?? {};

    emit(state.copyWith(state: DrugPrescriptionStates.savingDrugs));

    if (savedDrugs.isEmpty) {
      savedDrugs.addAll({
        patientId: [drug]
      });
    } else {
      if (savedDrugs.containsKey(patientId)) {
        savedDrugs[patientId] = [...savedDrugs[patientId]!, drug];
      } else {
        savedDrugs.addAll({
          patientId: [drug]
        });
      }
    }

    emit(state.copyWith(state: DrugPrescriptionStates.drugsSaved, savedDrugs: savedDrugs));
  }

  List<Drug>? getSavedDrugs(patientId) {
    return state.savedDrugs?[patientId];
  }

  void removeSavedDrug(patientId, Drug drug) {
    emit(state.copyWith(state: DrugPrescriptionStates.removingDrug));
    List<Drug> drugs = state.savedDrugs?[patientId] ?? [];

    Map<String, List<Drug>> newSavedDrugs = state.savedDrugs ?? {};

    drugs.remove(drug);
    newSavedDrugs[patientId] = drugs;

    emit(state.copyWith(
      state: DrugPrescriptionStates.drugRemoved,
      savedDrugs: newSavedDrugs,
    ));
  }

  void clearSavedDrugs(patientId) {
    emit(state.copyWith(state: DrugPrescriptionStates.clearingSavedDrugs));
    if (state.savedDrugs?.containsKey(patientId) == true) {
      state.savedDrugs?[patientId] = [];
    }

    emit(state.copyWith(state: DrugPrescriptionStates.savedDrugsCleared));
  }

  /*void searchDrugs(String query) {
    emit(state.copyWith(state: DrugPrescriptionStates.fetchingDrugs));

    final List<Drug> drugs = SampleObjects.drugs.where((drug) {
      final String modifiedQuery = '${drug.name} ${drug.contents}';
      final regex = RegExp(query, caseSensitive: false);

      return regex.hasMatch(modifiedQuery);
    }).toList();

    emit(state.copyWith(state: DrugPrescriptionStates.drugsFetched, drugs: drugs));
  }*/

  void fetchFrequentlySearchedDrugs() async {
    emit(state.copyWith(state: DrugPrescriptionStates.fetchingFrequentlySearchedDrugs));

    try {
      List<Drug> drugs = await service.getFrequentlySearchedDrugs();

      emit(state.copyWith(state: DrugPrescriptionStates.frequentlySearchedDrugsFetched, frequentlySearchedDrugs: drugs));
    } catch (error) {
      log('Failed to load appointments: $error');

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
}
