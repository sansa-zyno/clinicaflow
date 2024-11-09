// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appointment_cubit.dart';

class AppointmentState {
  final AppointmentStates state;
  List<Appointment>? appointments;
  int totalCount;
  String? patientId;

  AppointmentState({required this.state, this.totalCount = 0, this.appointments, this.patientId});

  AppointmentState copyWith({
    AppointmentStates? state,
    List<Appointment>? appointments,
    int? totalCount,
    String? patientId,
  }) {
    return AppointmentState(
        state: state ?? this.state,
        appointments: appointments ?? this.appointments,
        totalCount: totalCount ?? this.totalCount,
        patientId: patientId ?? this.patientId);
  }
}
