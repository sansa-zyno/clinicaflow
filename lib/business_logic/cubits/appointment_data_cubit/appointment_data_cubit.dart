import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/appointmentdata.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';

part 'appointment_data_state.dart';

class AppointmentDataCubit extends Cubit<AppointmentDataState> {
  AppointmentDataCubit()
      : super(AppointmentDataState(state: AppointmentDataStates.initial));

  List<Appointments> get _appointments => state.appointments ?? [];

  void addAppointment(Appointments appointment) {
    final newAppointments = _appointments;

    newAppointments.add(appointment);

    emit(state.copyWith(
        state: AppointmentDataStates.appointmentAdded,
        appointments: newAppointments));
  }

  void deleteAppointment(Appointments appointment) {
    final newAppointments = _appointments;
    newAppointments.removeWhere((element) => element == appointment);

    emit(state.copyWith(state: AppointmentDataStates.appointmentDeleted));
  }
}
