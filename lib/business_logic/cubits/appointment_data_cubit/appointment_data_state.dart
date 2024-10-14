// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appointment_data_cubit.dart';

class AppointmentDataState {
  final AppointmentDataStates state;

  final List<Appointments>? appointments;
  AppointmentDataState({
    required this.state,
    this.appointments,
  });

  

  AppointmentDataState copyWith({
    AppointmentDataStates? state,
    List<Appointments>? appointments,
  }) {
    return AppointmentDataState(
      state: state ?? this.state,
      appointments: appointments ?? this.appointments,
    );
  }
}
