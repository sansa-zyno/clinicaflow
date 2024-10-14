// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';

class VitalsResponse {
  final bool success;
  final String? message;
  final List<Vital>? vitals;
  VitalsResponse({
    required this.success,
    this.message,
    this.vitals,
  });
}
