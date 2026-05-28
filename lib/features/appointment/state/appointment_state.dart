// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../viewmodel/appointment_cubit.dart';

class AppointmentState {
  final AppointmentStates state;
  List<Appointment>? appointments;
  int totalCount;
  String? id;
  Appointment? appointmentDetails;
  Map? patientsHelped;
  Future<Map?> Function()? showBottomsSheet;
  String? error;
  Invoice? invoiceDetails;

  AppointmentState({
    required this.state,
    this.totalCount = 0,
    this.appointments,
    this.id,
    this.appointmentDetails,
    this.patientsHelped,
    this.showBottomsSheet,
    this.error,
    this.invoiceDetails,
  });

  AppointmentState copyWith(
      {AppointmentStates? state,
      List<Appointment>? appointments,
      int? totalCount,
      String? id,
      Appointment? appointmentDetails,
      Map? patientsHelped,
      Future<Map?> Function()? showBottomsSheet,
      String? error,
      Invoice? invoiceDetails}) {
    return AppointmentState(
      state: state ?? this.state,
      appointments: appointments ?? this.appointments,
      totalCount: totalCount ?? this.totalCount,
      id: id,
      appointmentDetails: appointmentDetails ?? this.appointmentDetails,
      patientsHelped: patientsHelped ?? this.patientsHelped,
      showBottomsSheet: showBottomsSheet ?? this.showBottomsSheet,
      error: error ?? this.error,
      invoiceDetails: invoiceDetails ?? this.invoiceDetails,
    );
  }
}
