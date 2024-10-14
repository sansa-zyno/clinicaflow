import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_detail/patient_detail_state.dart';
import 'package:healtether_clinic_app/data_layer/services/patients_service/patient_service.dart';

class PatientDetailCubit extends Cubit<PatientDetailState> {
  PatientDetailCubit(this.service) : super(PatientDetailInitialState());

  PatientService service;
  void fetchData(String id) {
    emit(PatientDetailLoadingState());

    service
        .getPatientById(id)
        .then((value) => emit(PatientDetailLoadedState(data: value)));
  }
}
