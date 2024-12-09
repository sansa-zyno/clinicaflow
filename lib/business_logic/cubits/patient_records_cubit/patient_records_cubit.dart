import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_response_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/patient_create_model.dart';
import 'package:healtether_clinic_app/data_layer/services/patients_service/patient_service.dart';
// import 'package:healtether_clinic_app/data_layer/services/staff_service/get_staff_service.dart';
// import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
// import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_request_model.dart';
// import 'package:healtether_clinic_app/data_layer/models/staff_model/get_staff_request_model.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
// import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

part 'patient_records_state.dart';

class PatientRecordsCubit extends Cubit<PatientRecordsState> {
  PatientRecordsCubit() : super(PatientRecordsState(state: PatientRecordsStates.initial));

  PatientService service = PatientService();

  Future<void> postPatient(PatientCreate patientCreate) async {
    emit(state.copyWith(state: PatientRecordsStates.postingPatient));
    try {
      await service.postPatient(patientCreate);
      emit(state.copyWith(state: PatientRecordsStates.patientPosted));
    } catch (error) {
      final errorMessage = error.toString();
      log('Failed to create patient: $error');
      emit(state.copyWith(errorMessage: errorMessage, state: PatientRecordsStates.postingPatientFailed));
    }
  }

  Future<void> updatePatient(PatientCreate patientCreate, String id) async {
    emit(state.copyWith(state: PatientRecordsStates.postingPatient));
    try {
      await service.updatePatient(patientCreate, id);
      // final List<PatientOverviewModel> newPatients = state.patients != null ? [...state.patients!] : [];
      // newPatients.removeWhere((patient) => patient.sId == id);
      emit(state.copyWith(state: PatientRecordsStates.patientPosted));
    } catch (error) {
      final errorMessage = error.toString();
      emit(state.copyWith(errorMessage: errorMessage, state: PatientRecordsStates.postingPatientFailed));
    }
  }

  void fetchPatients() async {
    emit(state.copyWith(state: PatientRecordsStates.fetchingPatients));
    try {
      PatientResponse getPatient = await service.fetchPatients();
      final patients = getPatient.data ?? [];
      final totalCount = getPatient.totalCount ?? 0;

      emit(state.copyWith(state: PatientRecordsStates.patientsFetched, patients: patients, totalCount: totalCount));
    } catch (error) {
      print('Failed to load patients: $error');

      emit(state.copyWith(state: PatientRecordsStates.fetchingPatientsFailed));
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      emit(state.copyWith(state: PatientRecordsStates.deletingPatient));
      await service.deletePatient(id);
      final List<PatientOverviewModel> newPatients = state.patients != null ? [...state.patients!] : [];
      newPatients.removeWhere((patient) => patient.sId == id);

      emit(state.copyWith(patients: newPatients, state: PatientRecordsStates.patientDeleted));
    } catch (error) {
      emit(state.copyWith(state: PatientRecordsStates.deletingPatientFailed));
      print('Failed to delete patient: $error');
      // throw Exception('Failed to delete patient');
    }
  }
}
