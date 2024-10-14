// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';

class SymptomsAndDiagnosisResponse {
  final bool success;
  final String? message;
  final List<Symptom>? associatedSymptoms;
  final List<Symptom>? differentialDiagnosis;
  SymptomsAndDiagnosisResponse({
    required this.success,
    this.message,
    required this.associatedSymptoms,
    required this.differentialDiagnosis,
  });

  @override
  String toString() {
    return 'SymptomsAndDiagnosisResponse(success: $success, message: $message, associatedSymptoms: $associatedSymptoms, differentialDiagnosis: $differentialDiagnosis)';
  }
}
