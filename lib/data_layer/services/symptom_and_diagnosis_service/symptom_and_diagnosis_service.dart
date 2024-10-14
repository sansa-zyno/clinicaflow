import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/response_models/symptoms_and_diagnoses_response.dart';
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';
import 'package:healtether_clinic_app/data_layer/services/base_service.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

class SymptomAndDiagnosisService extends BaseService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  @override
  extractMessage(response) {
    log("RESPONSE TO EXTRACT: $response");

    if (response is AppError) return response;

    if (response['success'] == true) {
      return SymptomsAndDiagnosisResponse(
          success: response['success'] == true,
          associatedSymptoms: response['Associated Symptoms'] != null ? symptoms(response['Associated Symptoms'], type: "sx") : null,
          differentialDiagnosis: response['Differential Diagnoses'] != null ? symptoms(response['Differential Diagnoses'], type: 'Dx') : null,
          message: response['message']);
    } else {
      return AppError.errorObject(response);
    }
  }

  List<Symptom> symptoms(List<dynamic> response, {required String type}) {
    return response.map((e) {
      return Symptom(name: e, type: type);
    }).toList();
  }

  Future<List<Symptom>> getFrequentlySearchedSymptoms() async {
    await fetchToken();

    final response = await HttpService.get(ApiEndPoint.getFrequencyForPrescription(clinicId: clinicId), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Symptom> symptoms = (jsonResponse['symptoms'] as List).map((map) => Symptom.fromMap(map, 'Sx')).toList();

      return symptoms;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }
}
