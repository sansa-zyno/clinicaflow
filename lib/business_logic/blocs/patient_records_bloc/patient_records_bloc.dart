import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_response_model.dart';
import 'package:healtether_clinic_app/data_layer/services/patients_service/patient_service.dart';
import 'package:meta/meta.dart';

part 'patient_records_event.dart';

part 'patient_records_state.dart';

class PatientRecordsBloc
    extends Bloc<PatientRecordsEvent, PatientRecordsState> {
  PatientRecordsBloc() : super(PatientRecordsInitial()) {
    on<LoadPatientRecordsEvent>(loadPatientRecordsEvent);
    on<LoadPatientFullRecordEvent>(loadPatientFullRecordEvent);
  }

  FutureOr<void> loadPatientRecordsEvent(
      LoadPatientRecordsEvent event, Emitter<PatientRecordsState> emit) async {
    emit(PatientRecordsLoadingState());

    print("process started");
    try {
      PatientResponse patientResponse = await PatientService().fetchPatients();

      if (patientResponse.data?.isNotEmpty ?? false) {
        emit(PatientRecordLoadedState(patients: patientResponse?.data ?? []));
      } else {
        emit(PatientRecordLoadFailedState(
            error: "Unable to Fetch Patient Records"));
      }
    } catch (e) {
      emit(PatientRecordLoadFailedState(error: e.toString()));
    }
  }

  FutureOr<void> loadPatientFullRecordEvent(LoadPatientFullRecordEvent event,
      Emitter<PatientRecordsState> emit) async {
    try {
      emit(LoadingFullRecordState());

      PatientModel? patient =
          await PatientService().getFullPatientRecord(event.id);

      if (patient != null) {
        emit(SinglePatientRecordLoadedstate(patient: patient));
      } else {
        emit(SinglePatientFullRecordLoadFailedState());
      }
    } catch (e) {
      emit(SinglePatientFullRecordLoadFailedState());
    }
  }
}
