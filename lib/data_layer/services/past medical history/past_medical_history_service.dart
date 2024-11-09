import 'dart:developer';

import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class PastMedicalHistoryService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  Future<String> postPastMedicalHistory(
      {required String patientId,
      required List medications,
      required List allergies,
      required List familyHistory,
      required List pastHistory,
      required List pastProcedureHistory}) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postMedicalHistory(patientId: patientId, clientId: clinicId),
      token,
      {
        "medication": medications,
        "allergies": allergies,
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
}
