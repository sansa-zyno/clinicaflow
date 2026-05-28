import 'dart:developer';

import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/features/lab_test/model/lab_tests.dart';
import 'package:clinica_flow/core/network/http.service.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';

class LabTestService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<List<LabTest>> getFrequentlySearchedTests() async {
    await fetchToken();

    final response = await HttpService.get(
        ApiEndPoint.getFrequencyForPrescription(clinicId: clinicId), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<LabTest> labTests = (jsonResponse['labtest'] as List)
          .map((map) => LabTest.fromMap(map))
          .toList();

      return labTests;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }

  Future<String> postLabTest({
    required String patientId,
    required String appointmentId,
    required List<Map<String, dynamic>> labTests,
  }) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postLabtests(
          patientId: patientId,
          clientId: clinicId,
          appointmentId: appointmentId),
      token,
      {"labTests": labTests},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw 'Failed to save data: ${response.statusCode}';
    }
  }

  Future<List<LabTest>?> getSavedLabTests(
      {required String appointmentId}) async {
    await fetchToken();
    final response = await HttpService.get(
        ApiEndPoint.getWholePrescriptions(
          appointmentId: appointmentId,
          clientId: clinicId,
        ),
        token);
    if (response.statusCode == 200) {
      if (response.data['prescriptions'] != null) {
        List<LabTest>? labTests =
            (response.data['prescriptions']['labTests'] as List?)
                ?.map((e) => LabTest.fromMap(e))
                .toList();
        return labTests;
      } else {
        return null;
      }
    } else {
      throw 'Failed to retrieve data: ${response.statusCode}';
    }
  }
}
