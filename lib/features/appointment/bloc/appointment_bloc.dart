import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:clinica_flow/features/analytics/service/analytics_service.dart';
import 'appointment_event.dart';

part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AnalyticsService service;

  AppointmentBloc(this.service) : super(InitialAppointmentState()) {
    on<FetchDataEvent>(_fetchData);
    on<SelectDoctorEvent>(_selectDoctor);
  }

  void _fetchData(FetchDataEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      Map<String, dynamic> apiData = await service.fetchData();
      List<dynamic> doctorsData = apiData['data'];

      if (doctorsData.isNotEmpty) {
        Map<String, double> modeOfConsultationData = {
          'Physical consultation': (doctorsData.first['modeOfConsultation']
                  ['Physical consultation'] as num)
              .toDouble(),
          'Virtual consultation': (doctorsData.first['modeOfConsultation']
                  ['Virtual consultation'] as num)
              .toDouble(),
        };
        Map<String, double> appointmentsBookingData = {
          'In the hospitals': (doctorsData.first['appointmentsBooking']
                  ['In the hospitals'] as num)
              .toDouble(),
          'By Whatsapp Assistance': (doctorsData.first['appointmentsBooking']
                  ['By Whatsapp Assistance'] as num)
              .toDouble(),
        };
        Map<String, double> appointmentsAnalysisData = {
          'Done': (doctorsData.first['appointmentsAnalysis']['Done'] as num)
              .toDouble(),
          'Pending':
              (doctorsData.first['appointmentsAnalysis']['Pending'] as num)
                  .toDouble(),
        };

        List<String> doctorNames = doctorsData
            .map<String>((doctorData) => doctorData['doctorName'] as String)
            .toList();

        emit(AppointmentLoaded(
          modeOfConsultationData,
          appointmentsBookingData,
          appointmentsAnalysisData,
          doctorNames: doctorNames,
        ));
      } else {
        emit(AppointmentError('No data available'));
      }
    } catch (error) {
      emit(AppointmentError('Error fetching data: $error'));
    }
  }

  void _selectDoctor(
      SelectDoctorEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());

    try {
      Map<String, dynamic> apiData = await service.fetchData();
      List<dynamic> doctorsData = apiData['data'];

      var selectedDoctorData = doctorsData.firstWhere(
          (doctorData) => doctorData['doctorName'] == event.selectedDoctor,
          orElse: () => null);
      if (selectedDoctorData != null) {
        var modeOfConsultationData = {
          "Physical consultation": (selectedDoctorData['modeOfConsultation']
                  ['Physical consultation'] as num)
              .toDouble(),
          "Virtual consultation": (selectedDoctorData['modeOfConsultation']
                  ['Virtual consultation'] as num)
              .toDouble(),
        };
        var appointmentsBookingData = {
          "In the hospitals": (selectedDoctorData['appointmentsBooking']
                  ['In the hospitals'] as num)
              .toDouble(),
          "By Whatsapp Assistance": (selectedDoctorData['appointmentsBooking']
                  ['By Whatsapp Assistance'] as num)
              .toDouble(),
        };
        var appointmentsAnalysisData = {
          "Done": (selectedDoctorData['appointmentsAnalysis']['Done'] as num)
              .toDouble(),
          "Pending":
              (selectedDoctorData['appointmentsAnalysis']['Pending'] as num)
                  .toDouble(),
        };

        // Use the doctor names fetched in _fetchData method
        List<String> doctorNames = doctorsData
            .map<String>((doctorData) => doctorData['doctorName'] as String)
            .toList();

        emit(AppointmentLoaded(
          modeOfConsultationData,
          appointmentsBookingData,
          appointmentsAnalysisData,
          doctorNames: doctorNames,
        ));
      }
    } catch (error) {
      emit(AppointmentError('Error fetching data: $error'));
    }
  }
}
