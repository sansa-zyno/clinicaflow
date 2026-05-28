// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinica_flow/features/patient/model/patient_model.dart';

abstract class PatientDetailState {}

class PatientDetailInitialState extends PatientDetailState {}

class PatientDetailLoadingState extends PatientDetailState {}

class PatientDetailLoadedState extends PatientDetailState {
  PatientModel data;
  PatientDetailLoadedState({
    required this.data,
  });
}
