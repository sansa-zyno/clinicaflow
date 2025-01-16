import 'dart:developer';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/history_item/history_item.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class PastMedicalHistoryService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<String> postPastMedicalHistory(
      {required String patientId,
      required List<Map<String, dynamic>> medication,
      required List<Map<String, dynamic>> allergies,
      required List<Map<String, dynamic>> familyHistory,
      required List<Map<String, dynamic>> pastHistory,
      required List<Map<String, dynamic>> pastProcedureHistory}) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postMedicalHistory(patientId: patientId, clientId: clinicId),
      token,
      {
        "allergies": allergies,
        "medication": medication,
        "familyHistory": familyHistory,
        "pastHistory": pastHistory,
        "pastProcedureHistory": pastProcedureHistory
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw 'Failed to save data: ${response.statusCode}';
    }
  }

  Future<Map<String, List<HistoryItem>?>> getPastMedicalHistory({required String patientId}) async {
    await fetchToken();
    final response = await HttpService.get(ApiEndPoint.getPastMedicalHistory(patientId: patientId, clientId: clinicId), token);
    if (response.statusCode == 200) {
      //log(response.data.toString());
      if (response.data == null) {
        return {
          "allergies": null,
          "medication": null,
          "familyHistory": null,
          "pastHistory": null,
          "pastProcedureHistory": null,
        };
      } else {
        List<HistoryItem>? allergies = (response.data['allergies'] as List?)?.map((e) => HistoryItem.fromMap(e)).toList();
        List<HistoryItem>? medication = (response.data['medication'] as List?)?.map((e) => HistoryItem.fromMap(e)).toList();
        List<HistoryItem>? familyHistory = (response.data['familyHistory'] as List?)?.map((e) => HistoryItem.fromMap(e)).toList();
        List<HistoryItem>? pastHistory = (response.data['pastHistory'] as List?)?.map((e) => HistoryItem.fromMap(e)).toList();
        List<HistoryItem>? pastProcedureHistory = (response.data['pastProcedureHistory'] as List?)?.map((e) => HistoryItem.fromMap(e)).toList();

        return {
          "allergies": allergies,
          "medication": medication,
          "familyHistory": familyHistory,
          "pastHistory": pastHistory,
          "pastProcedureHistory": pastProcedureHistory
        };
      }
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }
}
