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

  Future<String> postLabTest({required String patientId, required String appointmentId, required List labTests}) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postLabtests(patientId: patientId, clientId: clinicId, appointmentId: appointmentId),
      token,
      {"labTests": labTests},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw 'Failed to save data: ${response.statusCode}';
    }
  }

  Future<List<LabTest>?> getSavedLabTests({required String appointmentId}) async {
    await fetchToken();
    final response = await HttpService.get(ApiEndPoint.getWholePrescriptionsAndVitals(appointmentId: appointmentId, clientId: clinicId), token);
    if (response.statusCode == 200) {
      if (response.data['prescriptions'] != null) {
        List<LabTest>? labTests = (response.data['prescriptions']['labTests'] as List?)?.map((e) => LabTest.fromMap(e)).toList();
        return labTests;
      } else {
        return null;
      }
    } else {
      throw 'Failed to retrieve data: ${response.statusCode}';
    }
  }
}
