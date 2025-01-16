import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_response_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/patient_create_model.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import '../../../constants/api.dart';
import '../shared_preferences_service.dart';

class PatientService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<String> getPatientId() async {
    await fetchToken();
    final response = await HttpService.get(
      ApiEndPoint.getPatientId(clinicId: clinicId),
      token,
    );
    if (response.statusCode == 200) {
      if (response.data['patientId'] != null) {
        String prefix = response.data['patientId']['prefix'];
        String suffix = response.data['patientId']['suffix'];
        String currentPatientId = (response.data['patientId']['currentPatientId'] as int).toString();
        return '${prefix}_${currentPatientId}_$suffix';
      } else {
        throw Exception('Failed to create patient id: ${response.statusCode}');
      }
    } else {
      throw Exception('Failed to create patient id: ${response.statusCode}');
    }
  }

  Future<bool> postPatient(PatientCreate patientCreate) async {
    await fetchToken();
    Map<String, dynamic> map = patientCreate.toJson();
    String patientId = await getPatientId();
    map['patientId'] = patientId;
    log('patientId  ${map['patientId']}');
    final response = await HttpService.post(
      ApiEndPoint.postPatient,
      token,
      {
        "patientData": map,
      },
    );
    if (response.statusCode == 200) {
      return response.data['success'];
    } else {
      throw Exception('Failed to create patient');
    }
  }

  Future<bool> updatePatient(PatientCreate patientCreate, String id) async {
    log(id);
    await fetchToken();
    Map<String, dynamic> map = patientCreate.toJson();
    map.addAll({'id': id});
    final response = await HttpService.post(ApiEndPoint.updatePatient, token, {
      "patientData": map,
    });
    if (response.statusCode == 200) {
      return response.data['success'];
    } else {
      throw Exception('Failed to update patient');
    }
  }

  Future<PatientResponse> fetchPatients() async {
    await fetchToken();
    final response = await HttpService.get(
      ApiEndPoint.getPatients(clinicId: clinicId),
      token,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      //log("Patient data >>>>>>> " + data.toString());
      return PatientResponse.fromJson(data);
    } else {
      throw Exception('Failed to load patients: ${response.statusCode}');
    }
  }

  Future<PatientByIdModel> getPatientById(String id) async {
    await fetchToken();
    final response = await HttpService.get(
      ApiEndPoint.getPatientById(id: id),
      token,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      //log("res:::::${data}");
      return PatientByIdModel.fromJson(data);
    } else {
      throw Exception('Failed to load patient details: ${response.statusCode}');
    }
  }

  Future<void> deletePatient(String id) async {
    await fetchToken();
    final response = await HttpService.delete(
      ApiEndPoint.deletePatientById(id: id),
      token,
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Delete Patient successful');
      }
    } else {
      throw Exception('Failed to delete patient: ${response.statusCode}');
    }
  }

  /*Future<PatientModel?> getFullPatientRecord(String id) async {
    await fetchToken();
    try {
      final response = await HttpService.get(
          ApiEndPoint.getFullPatientRecord(id: id), token);

      if (response.statusCode == 200) {
        var result = response.data;

        PatientModel patient = PatientModel.fromJson(result);

        if (kDebugMode) {
          print(patient);
        }
        return patient;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }*/
}
