// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinica_flow/features/analytics/model/patient_age_model.dart';

abstract class PatientAgeState {}

class PatinetAgeInitialState extends PatientAgeState {}

class PatinetAgeLoadingState extends PatientAgeState {}

class PatinetAgeLoadedState extends PatientAgeState {
  List<PatientAgeModel>? data;
  PatinetAgeLoadedState({
    required this.data,
  });
}

class PatinetAgeErrorState extends PatientAgeState {}
