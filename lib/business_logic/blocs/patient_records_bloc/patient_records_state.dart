part of 'patient_records_bloc.dart';

@immutable
sealed class PatientRecordsState {}

final class PatientRecordsInitial extends PatientRecordsState {}

final class PatientRecordLoadedState extends PatientRecordsState{

  final List<dynamic> patients;

  PatientRecordLoadedState({required this.patients});
}

final class PatientRecordLoadFailedState extends PatientRecordsState{

  final String error;

  PatientRecordLoadFailedState({required this.error});

}

final class PatientRecordsLoadingState extends PatientRecordsState{}

final class SinglePatientRecord extends PatientRecordsState{}


final class SinglePatientRecordLoadedstate extends SinglePatientRecord{

  final PatientModel patient;

  SinglePatientRecordLoadedstate({required this.patient});
}

final class LoadingFullRecordState extends SinglePatientRecord{}

final class SinglePatientFullRecordLoadFailedState extends SinglePatientRecord{}

