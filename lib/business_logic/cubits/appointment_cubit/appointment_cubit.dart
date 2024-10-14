import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/services/appointment_service/appointment_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit()
      : super(AppointmentState(state: AppointmentStates.initial));

  AppointmentServices service = AppointmentServices();

  Future<void> fetchAppointments() async {
    emit(AppointmentState(state: AppointmentStates.fetchingAppointments));

    try {
      AppointmentModel appointmentModel = await service.fetchAppointments();
      final appointments = appointmentModel.data ?? [];
      final totalCount = appointmentModel.totalCount ?? 0;

      emit(state.copyWith(
          state: AppointmentStates.appointmentsFetched,
          totalCount: totalCount,
          appointments: appointments));
    } catch (error) {
      log('Failed to load appointments: $error');

      emit(state.copyWith(state: AppointmentStates.fetchingAppointmentsFailed));
    }
  }

  Future<void> createAppointment(Map map) async {
    emit(AppointmentState(state: AppointmentStates.creatingAppointments));

    try {
      await service.bookAppointment(
          mobile: map['mobile'],
          name: map['name'],
          gender: map['gender'],
          age: map['age'],
          birthDate: map['birthDate'],
          appointmentDate: map['appointmentDate'],
          timeSlot: map['timeSlot'],
          reason: map['reason'],
          virtualConsultation: map['virtualConsultation'],
          patientId: map['patientId'],
          doctorId: map['doctorId'],
          doctorName: map['doctorName'],
          clinicPatientId: map['clinicPatientId']);

      emit(state.copyWith(
        state: AppointmentStates.appointmentsCreated,
      ));
    } catch (error) {
      log('Failed to create appointments: $error');

      emit(state.copyWith(state: AppointmentStates.creatingAppointmentsFailed));
    }
  }
}
