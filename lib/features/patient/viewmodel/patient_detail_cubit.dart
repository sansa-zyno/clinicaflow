import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/patient/state/patient_detail_state.dart';
import 'package:clinica_flow/features/patient/service/patient_service.dart';

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
