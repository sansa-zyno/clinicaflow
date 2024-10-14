part of 'patient_records_bloc.dart';

@immutable
sealed class PatientRecordsEvent {}

final class LoadPatientRecordsEvent extends PatientRecordsEvent{

  final String id;

  LoadPatientRecordsEvent({required this.id});
}

final class LoadPatientFullRecordEvent extends PatientRecordsEvent{

  final String id;

  LoadPatientFullRecordEvent({required this.id});


}