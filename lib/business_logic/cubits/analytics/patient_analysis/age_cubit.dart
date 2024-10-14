import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/business_logic/cubits/analytics/patient_analysis/age_state.dart';
import 'package:healtether_clinic_app/data_layer/models/analytics/patient_analysis/patient_age_model.dart';
import 'package:healtether_clinic_app/data_layer/services/analytics/analytics_service.dart';

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
