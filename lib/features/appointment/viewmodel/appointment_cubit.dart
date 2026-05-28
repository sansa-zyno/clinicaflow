import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
import 'package:clinica_flow/features/payment/model/invoice.dart'
    hide Appointment;
import 'package:clinica_flow/features/appointment/service/appointment_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';
part '../state/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit()
      : super(AppointmentState(state: AppointmentStates.initial));

  AppointmentServices service = AppointmentServices();

  Future<void> fetchAppointments({required String status}) async {
    emit(state.copyWith(state: AppointmentStates.fetchingAppointments));
    try {
      AppointmentModel appointmentModel =
          await service.fetchAppointments(status: status);
      final appointments = appointmentModel.data ?? [];
      final totalCount = appointmentModel.totalCount ?? 0;
      log('list of appointments.     ' + appointments.toString());
      emit(state.copyWith(
        state: AppointmentStates.appointmentsFetched,
        totalCount: totalCount,
        appointments: appointments,
      ));
    } catch (error) {
      log('Failed to load appointments: $error');
      emit(state.copyWith(state: AppointmentStates.fetchingAppointmentsFailed));
    }
  }

  Future<void> createAppointment(Map map) async {
    emit(state.copyWith(state: AppointmentStates.creatingAppointments));
    try {
      String id = await service.bookAppointment(
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
      emit(
          state.copyWith(state: AppointmentStates.appointmentsCreated, id: id));
    } catch (error) {
      log('Failed to create appointments: $error');
      emit(state.copyWith(state: AppointmentStates.creatingAppointmentsFailed));
    }
  }

  reScheduleAppointment(
      {required String id,
      required String appointmentDate,
      required String timeSlot}) async {
    emit(state.copyWith(state: AppointmentStates.reschedulingAppointment));
    try {
      await service.reScheduleAppointment(
          id: id, appointmentDate: appointmentDate, timeSlot: timeSlot);
      emit(state.copyWith(state: AppointmentStates.appointmentRescheduled));
    } catch (error) {
      log('Failed to reschedule appointment: $error');
      emit(state.copyWith(
          state: AppointmentStates.reschedulingAppointmentFailed));
    }
  }

  followupAppointment(
      {required String id,
      required String appointmentDate,
      required String timeSlot}) async {
    emit(state.copyWith(state: AppointmentStates.followingupAppointment));
    try {
      await service.followupAppointment(
          id: id, appointmentDate: appointmentDate, timeSlot: timeSlot);
      emit(state.copyWith(state: AppointmentStates.appointmentFollowedup));
    } catch (error) {
      log('Failed to follow up appointment: $error');
      emit(state.copyWith(
          state: AppointmentStates.followingupAppointmentFailed));
    }
  }

  cancellAppointment({required String id}) async {
    emit(state.copyWith(state: AppointmentStates.cancellingAppointment));
    try {
      await service.cancellAppointment(id: id);
      emit(state.copyWith(state: AppointmentStates.appointmentCancelled));
    } catch (error) {
      log('Failed to cancell appointment: $error');
      emit(
          state.copyWith(state: AppointmentStates.cancellingAppointmentFailed));
    }
  }

  Future<void> getAppointmentById({required String id}) async {
    emit(state.copyWith(state: AppointmentStates.fetchingAppointmentById));

    try {
      Appointment appointment = await service.getAppointmentById(id: id);
      emit(state.copyWith(
        state: AppointmentStates.appointmentByIdFetched,
        appointmentDetails: appointment,
      ));
    } catch (error) {
      log('Failed to get appointment Details: $error');
      emit(state.copyWith(
        state: AppointmentStates.fetchingAppointmentByIdFailed,
      ));
    }
  }

  Future<void> getCompletedAndRemainingAppointmentCount(
      {required String date}) async {
    emit(state.copyWith(
      state: AppointmentStates.fetchingAppointmentCount,
    ));
    try {
      Map patientsHelped =
          await service.getCompletedAndRemainingAppointmentCount(date: date);
      emit(state.copyWith(
        state: AppointmentStates.appointmentCountFetched,
        patientsHelped: patientsHelped,
      ));
    } catch (error) {
      log('Failed to get appointments data for this date: $error');
      emit(state.copyWith(
        state: AppointmentStates.fetchingAppointmentCountFailed,
      ));
    }
  }

  Future endConsultation({required String appointmentId}) async {
    emit(state.copyWith(state: AppointmentStates.endingConsultation));
    try {
      await service.endConsulation(appointmentId: appointmentId);
      emit(state.copyWith(state: AppointmentStates.consultationEnded));
    } catch (error) {
      log('Failed to end consultation: $error');
      emit(state.copyWith(state: AppointmentStates.endingConsultationFailed));
    }
  }

  setBottomsSheettt(Future<Map?> Function()? showBottomsSheet) {
    emit(state.copyWith(showBottomsSheet: showBottomsSheet));
  }

  Future getInvoiceById({required String invoiceId}) async {
    emit(state.copyWith(state: AppointmentStates.fetchingInvoice));
    try {
      Invoice invoiceDetails =
          await service.getInvoiceById(invoiceId: invoiceId);
      emit(state.copyWith(
          state: AppointmentStates.invoiceFetched,
          invoiceDetails: invoiceDetails));
    } catch (error) {
      log('Failed to get invoice: $error');
      emit(state.copyWith(state: AppointmentStates.fetchingInvoiceFailed));
      rethrow;
    }
  }

  addInvoice({
    required String invoiceId,
    required List<Map<String, dynamic>> treatments,
    required int discount,
  }) async {
    emit(state.copyWith(state: AppointmentStates.addingInvoice));
    try {
      await service.addInvoiceDetails(
          invoiceId: invoiceId, treatments: treatments, discount: discount);
      emit(state.copyWith(state: AppointmentStates.invoiceAdded));
    } catch (error) {
      log('Failed to add invoice: $error');
      emit(state.copyWith(
          state: AppointmentStates.addingInvoiceFailed,
          error: error.toString()));
    }
  }
}
