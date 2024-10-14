part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentState {}

class InitialAppointmentState extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final Map<String, double> modeOfConsultationData;
  final Map<String, double> appointmentsBookingData;
  final Map<String, double> appointmentsAnalysisData;
  final List<String> doctorNames;

  AppointmentLoaded(this.modeOfConsultationData, this.appointmentsBookingData,
      this.appointmentsAnalysisData,
      {required this.doctorNames});

  @override
  List<Object?> get props => [
        doctorNames,
        modeOfConsultationData,
        appointmentsBookingData,
        appointmentsAnalysisData
      ];
}

class AppointmentError extends AppointmentState {
  final String errorMessage;
  AppointmentError(this.errorMessage);
}
