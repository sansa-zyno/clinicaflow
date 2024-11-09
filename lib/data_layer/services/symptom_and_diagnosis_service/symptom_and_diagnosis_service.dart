import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
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

  Future<Map<String, List<Symptom>>> ddxPredictions(List selectedSymptoms, List selectedDiagnosis) async {
    final response = await HttpService.dio.post(ApiEndPoint.symptomsAndDiagnosisPredictionAI,
        data: {"input_symptoms": selectedSymptoms, "input_diagnoses": selectedDiagnosis, "n_diseases": 6, "n_symptoms": 6, "min_symptoms": 2},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Symptom> associatedSymptoms = (jsonResponse['Associated Symptoms'] as List).map((item) => Symptom(name: item, type: 'Sx')).toList();
      List<Symptom> differentialDiagnosis = (jsonResponse['Differential Diagnoses'] as List).map((item) => Symptom(name: item, type: 'Dx')).toList();

      return {'Sx': associatedSymptoms, 'Dx': differentialDiagnosis};
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }

  Future<String> postSymtomsAndDiagnostics(
      {required String patientId, required String appointmentId, required List symptoms, required List diagnosis}) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postSymtomsAndDiagnostics(patientId: patientId, clientId: clinicId, appointmentId: appointmentId),
      token,
      {"symptoms": symptoms, "diagnosis": diagnosis},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw 'Failed to save data: ${response.statusCode}';
    }
  }

  Future<Map<String, List<Symptom>?>> getSavedSymptomsAndDiagnosis({required String appointmentId}) async {
    await fetchToken();
    final response = await HttpService.get(ApiEndPoint.getWholePrescriptionsAndVitals(appointmentId: appointmentId, clientId: clinicId), token);
    if (response.statusCode == 200) {
      if (response.data['prescriptions'] != null) {
        List<Symptom>? symptoms = (response.data['prescriptions']['symptoms'] as List?)?.map((e) => Symptom.fromMap(e, 'Sx')).toList();
        List<Symptom>? diagnosis = (response.data['prescriptions']['diagnosis'] as List?)?.map((e) => Symptom.fromMap(e, 'Dx')).toList();
        return {"symptoms": symptoms, "diagnosis": diagnosis};
      } else {
        return {"symptoms": null, "diagnosis": null};
      }
    } else {
      throw 'Failed to retrieve data: ${response.statusCode}';
    }
  }
}
