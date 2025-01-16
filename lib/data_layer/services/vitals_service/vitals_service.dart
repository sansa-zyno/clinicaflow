import 'dart:developer';

import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

/// This communicates with the api client, gets data from api and converts
/// it into dart objects (models) that can be used in the app
class VitalsService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<String> postVitals({
    required String patientId,
    required String appointmentId,
    required Map<String, dynamic> map,
  }) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postVitals(patientId: patientId, clientId: clinicId, appointmentId: appointmentId),
      token,
      map,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw 'Failed to save data: ${response.statusCode}';
    }
  }

  Future<Vital> getVitals({required String appointmentId, required String patientId}) async {
    await fetchToken();
    final response = await HttpService.get(ApiEndPoint.getVitalsAndPersonalHistory(appointmentId: appointmentId, patientId: patientId), token);
    if (response.statusCode == 200) {
      //log(response.data.toString());
      if (response.data['data'] != null) {
        Vital vital = Vital.fromMapWithPersonalHistory(response.data['data']);
        return vital;
      } else {
        return Vital();
      }
    } else {
      throw 'Failed to retrieve data: ${response.statusCode}';
    }
  }
}
