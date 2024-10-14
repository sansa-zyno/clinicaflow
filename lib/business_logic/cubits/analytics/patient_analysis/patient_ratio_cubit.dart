import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/business_logic/cubits/analytics/patient_analysis/patient_ratio_state.dart';
import 'package:healtether_clinic_app/data_layer/models/analytics/patient_analysis/patient_ratio_custom_model.dart';
import 'package:healtether_clinic_app/data_layer/models/analytics/patient_analysis/patient_ratio_monthly_model.dart';
import 'package:healtether_clinic_app/data_layer/models/analytics/patient_analysis/patient_ratio_weekly_model.dart';
import 'package:healtether_clinic_app/data_layer/services/analytics/analytics_service.dart';

class PatientRatioCubit extends Cubit<PatientRatioState> {
  PatientRatioCubit(this.service) : super(PatinetRatioInitialState());

  AnalyticsService service;

  void fetch(Map<String, String> myBody, int type) {
    emit(PatinetRatioLoadingState());
    service.fetchPatientRatio(myBody).then((value) {
      if (type == 1) {
        final List<PatientRatioCustomModel> todayData = value
            .map((data) => PatientRatioCustomModel.fromJson(data))
            .toList();
        emit(PatinetRatioLoadedState(data: todayData));
      }

      if (type == 2) {
        final List<PatientRatioMonthlyModel> monthlyData = value
            .map((data) => PatientRatioMonthlyModel.fromJson(data))
            .toList();
        emit(PatinetRatioLoadedState(data: monthlyData));
      }
      if (type == 3) {
        final List<PatientRatioWeeklyModel> weeklyData = value
            .map((data) => PatientRatioWeeklyModel.fromJson(data))
            .toList();
        emit(PatinetRatioLoadedState(data: weeklyData));
      }

      if (type == 4) {
        final List<PatientRatioCustomModel> customData = value
            .map((data) => PatientRatioCustomModel.fromJson(data))
            .toList();
        emit(PatinetRatioLoadedState(data: customData));
      }
    });
  }
}
