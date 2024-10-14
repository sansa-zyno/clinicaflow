// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart';

abstract class PatientDetailState {}

class PatientDetailInitialState extends PatientDetailState {}

class PatientDetailLoadingState extends PatientDetailState {}

class PatientDetailLoadedState extends PatientDetailState {
  PatientByIdModel data;
  PatientDetailLoadedState({
    required this.data,
  });
}
