// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../viewmodel/prescription_report_cubit.dart';

class PrescriptionReportState {
  final PrescriptionReportStates state;
  final PrescriptionReport? prescriptionReport;

  PrescriptionReportState({required this.state, this.prescriptionReport});

  PrescriptionReportState copyWith({
    PrescriptionReportStates? state,
    PrescriptionReport? prescriptionReport,
  }) {
    return PrescriptionReportState(
      state: state ?? this.state,
      prescriptionReport: prescriptionReport ?? this.prescriptionReport,
    );
  }
}
