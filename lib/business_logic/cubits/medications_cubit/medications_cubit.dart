import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/create_medications/create_medications_model.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/services/medications_service/medications_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
// import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

part 'medications_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(MedicationState(state: MedicationStates.initial));

  MedicationsService service = MedicationsService();

  void updateDiagnoses(List<String> diagnoses) {
    emit(state.copyWith(state: MedicationStates.diagnosesUpdated, selectedDiagnoses: diagnoses));
  }

  void updateNMedications(int count) {
    emit(state.copyWith(nMedications: count, state: MedicationStates.nMedicationsUpdated));
  }

  Future<void> createMedication() async {
    emit(state.copyWith(state: MedicationStates.creatingMedication));

    CreateMedications medications = CreateMedications(
      selectedDiagnoses: state.selectedDiagnoses,
      nMedications: state.nMedications,
    );

    try {
      CreateMedications? response = await service.createMedications(medications);

      if (response != null) {
        emit(state.copyWith(medicationResponse: response, state: MedicationStates.medicationsCreated));
      } else {
        const errorMessage = 'Failed to create medications';

        emit(state.copyWith(state: MedicationStates.creatingMedicationFailed, errorMessage: errorMessage));
      }
    } catch (e) {
      emit(state.copyWith(state: MedicationStates.creatingMedicationFailed, errorMessage: 'Error: $e'));
    }
  }

  Future<void> search(String query) async {
    emit(state.copyWith(state: MedicationStates.searchingMedications));
    try {
      final drugs = await service.searchDrugs(query);
      emit(state.copyWith(state: MedicationStates.searchingMedicationsSuccess, searchedMedications: drugs));
    } catch (e) {
      emit(state.copyWith(state: MedicationStates.searchingMedicationsFailed));
    }
  }
}
