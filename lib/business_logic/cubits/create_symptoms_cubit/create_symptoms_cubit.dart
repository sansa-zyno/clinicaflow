import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/create_medications/create_symptoms_model.dart';
import 'package:healtether_clinic_app/data_layer/services/create_symptoms_service/create_symptoms_service.dart';
// import 'package:healtether_clinic_app/data_layer/services/staff_service/get_staff_service.dart';
// import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
// import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_request_model.dart';
// import 'package:healtether_clinic_app/data_layer/models/staff_model/get_staff_request_model.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
// import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

part 'create_symptoms_state.dart';

class CreateSymptomsCubit extends Cubit<CreateSymptomsState> {
  CreateSymptomsCubit()
      : super(CreateSymptomsState(state: CreateSymptomsStates.initial));

  CreateSymptomsService service = CreateSymptomsService();

  Future<void> postCreateSymptoms(
    String searchText,
    List<String> selectedSymptoms,
    List<String> selectedDiagnoses,
  ) async {
    try {
      emit(state.copyWith(state: CreateSymptomsStates.postingSymptoms));
      final result = await service.createSymptoms(
          searchText, selectedSymptoms, selectedDiagnoses);

      final symptomsList = result['symptoms'] ?? [];
      final diagnosesList = result['diagnoses'] ?? [];

      emit(state.copyWith(state: CreateSymptomsStates.symptomsPosted,
          symptomsList: symptomsList, diagnosesList: diagnosesList));
    } catch (error) {
      final errorMessage = error.toString();
      emit(
          state.copyWith(state: CreateSymptomsStates.postingSymptomsFailed, errorMessage: errorMessage));
    }
  }
}
