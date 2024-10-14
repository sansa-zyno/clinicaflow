// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healtether_clinic_app/data_layer/models/medication_history/medication.dart';

class MedicationResponse {
  final bool success;
  final String? message;
  final Medication? medication;
  final List<Medication>? medications;
  MedicationResponse({
    required this.success,
    this.message,
    required this.medication,
    required this.medications,
  });
}
