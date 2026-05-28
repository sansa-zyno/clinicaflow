import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class FetchDataEvent extends AppointmentEvent {}

class SelectDoctorEvent extends AppointmentEvent {
  final String selectedDoctor;

  const SelectDoctorEvent(this.selectedDoctor);

  @override
  List<Object?> get props => [selectedDoctor];
}
