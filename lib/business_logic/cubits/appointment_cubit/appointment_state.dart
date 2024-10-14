// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appointment_cubit.dart';

class AppointmentState {
  final AppointmentStates state;
  List<Appointment>? appointments;
  int totalCount;

  AppointmentState(
      {required this.state, this.totalCount = 0, this.appointments});

  AppointmentState copyWith({
    AppointmentStates? state,
    List<Appointment>? appointments,
    int? totalCount,
  }) {
    return AppointmentState(
      state: state ?? this.state,
      appointments: appointments ?? this.appointments,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
