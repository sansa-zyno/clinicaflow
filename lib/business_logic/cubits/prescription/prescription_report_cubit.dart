import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/prescription/prescription_report.dart';
import 'package:healtether_clinic_app/data_layer/services/prescription/prescription_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
part 'prescription_report_state.dart';

class PrescriptionReportCubit extends Cubit<PrescriptionReportState> {
  PrescriptionReportCubit() : super(PrescriptionReportState(state: PrescriptionReportStates.initial));

  PrescriptionService service = PrescriptionService();

  getPrescriptionReport({required String appointmentId}) async {
    emit(state.copyWith(state: PrescriptionReportStates.fetchingReport));

    try {
      PrescriptionReport? prescriptionReport = await service.getPrescriptionReport(appointmentId: appointmentId);
      // emit success response
      emit(state.copyWith(state: PrescriptionReportStates.reportFetched, prescriptionReport: prescriptionReport));
    } catch (error) {
      log('Failed to load data: $error');
      // emit failed response
      emit(state.copyWith(
        state: PrescriptionReportStates.fetchingReportFailed,
      ));
    }
  }
}
