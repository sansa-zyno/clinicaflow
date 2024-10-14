// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healtether_clinic_app/data_layer/models/past_procedure/past_procedure.dart';

class PastProcedureResponse {
  final bool success;
  final String? message;
  final List<PastProcedure>? pastProcedures;
  final PastProcedure? pastProcedure;
  PastProcedureResponse({
    required this.success,
    this.message,
    this.pastProcedures,
    this.pastProcedure,
  });
}
