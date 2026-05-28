import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/analytics/state/age_state.dart';
import 'package:clinica_flow/features/analytics/model/patient_age_model.dart';
import 'package:clinica_flow/features/analytics/service/analytics_service.dart';

class AgeRatioCubit extends Cubit<PatientAgeState> {
  AgeRatioCubit(this.service) : super(PatinetAgeInitialState());
  AnalyticsService service;

  void fetch(Map<String, String> myBody) {
    emit(PatinetAgeLoadingState());
    service.fetchAgeRatio(myBody).then((value) {
      final List<PatientAgeModel> todayData =
          value.map((data) => PatientAgeModel.fromJson(data)).toList();
      emit(PatinetAgeLoadedState(data: todayData));
    });
  }
}
