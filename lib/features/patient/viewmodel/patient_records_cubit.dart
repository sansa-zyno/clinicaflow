import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/patient/model/patient_model.dart';
import 'package:clinica_flow/features/patient/service/patient_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';

part '../state/patient_records_state.dart';

class PatientRecordsCubit extends Cubit<PatientRecordsState> {
  PatientRecordsCubit()
      : super(PatientRecordsState(state: PatientRecordsStates.initial));

  PatientService service = PatientService();

  Future<void> postPatient(PatientModel patient) async {
    emit(state.copyWith(state: PatientRecordsStates.postingPatient));
    try {
      await service.postPatient(patient);
      emit(state.copyWith(state: PatientRecordsStates.patientPosted));
    } catch (error) {
      final errorMessage = error.toString();
      log('Failed to create patient: $error');
      emit(state.copyWith(
          errorMessage: errorMessage,
          state: PatientRecordsStates.postingPatientFailed));
    }
  }

  Future<void> updatePatient(PatientModel patient, String id) async {
    emit(state.copyWith(state: PatientRecordsStates.postingPatient));
    try {
      await service.updatePatient(patient, id);
      emit(state.copyWith(state: PatientRecordsStates.patientPosted));
    } catch (error) {
      final errorMessage = error.toString();
      emit(state.copyWith(
          errorMessage: errorMessage,
          state: PatientRecordsStates.postingPatientFailed));
    }
  }

  void fetchPatients() async {
    emit(state.copyWith(state: PatientRecordsStates.fetchingPatients));
    try {
      final patients = await service.fetchPatients();
      final totalCount = patients.length;

      emit(state.copyWith(
          state: PatientRecordsStates.patientsFetched,
          patients: patients,
          totalCount: totalCount));
    } catch (error) {
      log('Failed to load patients: $error');
      emit(state.copyWith(state: PatientRecordsStates.fetchingPatientsFailed));
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      emit(state.copyWith(state: PatientRecordsStates.deletingPatient));
      await service.deletePatient(id);
      emit(state.copyWith(state: PatientRecordsStates.patientDeleted));
    } catch (error) {
      log('Failed to delete patient: $error');
      emit(state.copyWith(state: PatientRecordsStates.deletingPatientFailed));
    }
  }
}
