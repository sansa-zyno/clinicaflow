// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'patient_records_cubit.dart';

class PatientRecordsState {
  final PatientRecordsStates state;

  List<PatientOverviewModel>? patients;
  int totalCount;
  String? errorMessage;
  PatientRecordsState({
    required this.state,
    this.patients,
    this.totalCount = 0,
    this.errorMessage,
  });

  PatientRecordsState copyWith({
    PatientRecordsStates? state,
    List<PatientOverviewModel>? patients,
    int? totalCount,
    String? errorMessage,
  }) {
    return PatientRecordsState(
      state: state ?? this.state,
      patients: patients ?? this.patients,
      totalCount: totalCount ?? this.totalCount,
      errorMessage: errorMessage,
    );
  }
}
