import 'dart:developer';

import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/features/prescription/model/prescription_report.dart';
import 'package:clinica_flow/core/network/http.service.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';

class PrescriptionService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  /*Future<Map<String, dynamic>?> getClinicDetails({required String id}) async {
    await fetchToken();
    try {
      final response = await HttpService.get(ApiEndPoint.getClinicDetails(id: id), token);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }*/

  Future<PrescriptionReport?> getPrescriptionReport(
      {required String appointmentId}) async {
    await fetchToken();
    try {
      final response = await HttpService.get(
          ApiEndPoint.getPrescriptionReport(
              appointmentId: appointmentId, clinicId: clinicId),
          token);
      if (response.statusCode == 200) {
        return PrescriptionReport.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
