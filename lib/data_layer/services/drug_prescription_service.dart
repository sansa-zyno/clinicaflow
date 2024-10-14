import 'dart:developer';

import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class DrugPrescriptionService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  Future<List<Drug>> getFrequentlySearchedDrugs() async {
    await fetchToken();

    final response = await HttpService.get(ApiEndPoint.getFrequencyForPrescription(clinicId: clinicId), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Drug> drugs = (jsonResponse['drugs'] as List).map((map) => Drug.fromMap(map)).toList();

      return drugs;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }

  Future<List<Drug>> searchDrugs(String query) async {
    await fetchToken();

    final response = await HttpService.get(ApiEndPoint.searchDrugs(query: query), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Drug> drugs = (jsonResponse['data'] as List).map((map) => Drug.fromMap(map)).toList();

      return drugs;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }
}
