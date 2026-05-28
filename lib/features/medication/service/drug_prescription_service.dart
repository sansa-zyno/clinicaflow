import 'dart:developer';

import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/features/medication/model/drug_model.dart';
import 'package:clinica_flow/core/network/http.service.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';

class DrugPrescriptionService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<List<Drug>> getFrequentlySearchedDrugs() async {
    await fetchToken();

    final response = await HttpService.get(
        ApiEndPoint.getFrequencyForPrescription(clinicId: clinicId), token);
    //log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Drug> drugs = (jsonResponse['drugs'] as List)
          .map((map) => Drug.fromMap(map))
          .toList();

      return drugs;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }

  Future<List<Drug>> searchDrugs(String query) async {
    await fetchToken();

    final response =
        await HttpService.get(ApiEndPoint.searchDrugs(query: query), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Drug> drugs = (jsonResponse['data'] as List)
          .map((map) => Drug.fromMap(map))
          .toList();

      return drugs;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }

  Future<String> postDrugPrescription({
    required String patientId,
    required String appointmentId,
    required List<Map<String, dynamic>> drugs,
    required String patientAdvice,
    required String privateNotes,
    required String followupDate,
    required String followupTimeSlot,
  }) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postDrugs(
          patientId: patientId,
          clientId: clinicId,
          appointmentId: appointmentId),
      token,
      {
        "drugs": drugs,
        "patientAdvice": patientAdvice,
        "privateNotes": privateNotes,
        "followUpDate": followupDate,
        "followUpTimeSlot": followupTimeSlot,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw 'Failed to save data: ${response.statusCode}';
    }
  }

  Future<Map<String, dynamic>?> getSavedDrugPrescription(
      {required String appointmentId}) async {
    await fetchToken();
    final response = await HttpService.get(
        ApiEndPoint.getWholePrescriptions(
            appointmentId: appointmentId, clientId: clinicId),
        token);
    if (response.statusCode == 200) {
      if (response.data['prescriptions'] != null) {
        List<Drug>? drugs =
            (response.data['prescriptions']['drugPrescriptions'] as List?)
                ?.map((e) => Drug.fromMap(e))
                .toList();
        String? patientAdvice = response.data['prescriptions']['patientAdvice'];
        String? privacyNotes = response.data['prescriptions']['privacyNotes'];
        String? followUpDate = response.data['prescriptions']['followUpDate'];
        String? followUpTimeSlot =
            response.data['prescriptions']['followUpTimeSlot'];

        return {
          'drugs': drugs,
          'patientAdvice': patientAdvice,
          'privacyNotes': privacyNotes,
          'followUpDate': followUpDate,
          'followUpTimeSlot': followUpTimeSlot,
        };
      } else {
        return null;
      }
    } else {
      throw 'Failed to retrieve data: ${response.statusCode}';
    }
  }
}
