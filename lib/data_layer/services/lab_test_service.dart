import 'dart:developer';

import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/lab_tests/lab_tests.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class LabTestService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  Future<List<LabTest>> getFrequentlySearchedTests() async {
    await fetchToken();

    final response = await HttpService.get(ApiEndPoint.getFrequencyForPrescription(clinicId: clinicId), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<LabTest> labTests = (jsonResponse['labtest'] as List).map((map) => LabTest.fromMap(map)).toList();

      return labTests;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }
}
