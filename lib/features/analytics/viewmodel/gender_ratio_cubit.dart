import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/analytics/state/gender_ratio_state.dart';
import 'package:clinica_flow/features/analytics/model/patient_gender_custom_model.dart';
import 'package:clinica_flow/features/analytics/model/patient_gender_ratio_monthy_model.dart';
import 'package:clinica_flow/features/analytics/model/patient_gender_ratio_weekly_model.dart';
import 'package:clinica_flow/features/analytics/service/analytics_service.dart';

class PatientGenderRatioCubit extends Cubit<PatientGenderRatioState> {
  PatientGenderRatioCubit(this.service)
      : super(PatinetGenderRatioInitialState());
  AnalyticsService service;

  void fetch(Map<String, String> myBody, int type) {
    emit(PatinetGenderRatioLoadingState());
    service.fetchGenderRatio(myBody).then((value) {
      if (type == 1) {
        final List<PatientGenderRatioCustomModel> todayData = value
            .map((data) => PatientGenderRatioCustomModel.fromJson(data))
            .toList();
        emit(PatinetGenderRatioLoadedState(data: [
          todayData[0].genderCount!,
          todayData[1].genderCount!,
          todayData[2].genderCount!
        ]));
      }

      if (type == 2) {
        final List<PatientGenderRatioMonthlyModel> monthlyData = value
            .map((data) => PatientGenderRatioMonthlyModel.fromJson(data))
            .toList();
        emit(PatinetGenderRatioLoadedState(data: [
          monthlyData[0].genderCount,
          monthlyData[1].genderCount,
          monthlyData[2].genderCount
        ]));
      }
      if (type == 3) {
        final List<PatientGenderRatioWeeklyModel> weeklyData = value
            .map((data) => PatientGenderRatioWeeklyModel.fromJson(data))
            .toList();
        emit(PatinetGenderRatioLoadedState(data: [
          weeklyData[0].genderCount,
          weeklyData[1].genderCount,
          weeklyData[2].genderCount
        ]));
      }

      if (type == 4) {
        final List<PatientGenderRatioCustomModel> customData = value
            .map((data) => PatientGenderRatioCustomModel.fromJson(data))
            .toList();
        emit(PatinetGenderRatioLoadedState(data: [
          customData[0].genderCount!,
          customData[1].genderCount!,
          customData[2].genderCount!
        ]));
      }
    });
  }
}
