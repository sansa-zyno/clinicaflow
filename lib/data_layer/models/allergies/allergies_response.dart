// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healtether_clinic_app/data_layer/models/allergies/allergies.dart';

class AllergyResponse {
  final bool success;
  final String? message;
  final Allergy? allergy;
  final List<Allergy>? allergies;
  AllergyResponse({
    required this.success,
    this.message,
    this.allergy,
    this.allergies,
  });
}
