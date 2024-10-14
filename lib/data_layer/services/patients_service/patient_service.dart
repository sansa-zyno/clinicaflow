import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_response_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/patient_create_model.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:http/http.dart' as http;
import '../../../constants/api.dart';
import '../shared_preferences_service.dart';

class PatientService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  Future<PatientResponse> fetchPatients() async {
    await fetchToken();
    final response = await HttpService.get(
      ApiEndPoint.getPatients(clinicId: clinicId),
      token,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      log("Patient data >>>>>>> " + data.toString());

      return PatientResponse.fromJson(data);
    } else {
      throw Exception('Failed to load patients: ${response.statusCode}');
    }
  }

  Future<PatientCreate> postPatient(PatientCreate patientCreate) async {
    try {
      await fetchToken();
      final body = json.encode(patientCreate.toJson());
      print(body);
      final response =
          await HttpService.post(ApiEndPoint.postPatient, token, body);
      print("res:::::${response.data}");
      if (response.statusCode == 200) {
        return PatientCreate.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to create patient');
      }
    } catch (e, strack) {
      print("strack:e:$e");
      print("strack:$strack");
      throw Exception('Failed to create patient throw catch');
    }
  }

  Future<PatientCreate> editPatient(PatientCreate patientCreate) async {
    try {
      await fetchToken();
      final body = json.encode(patientCreate.toJson());
      print(body);
      final response =
          await HttpService.post(ApiEndPoint.editPatient, token, body);
      print("res:::::${response.data}");
      if (response.statusCode == 200) {
        return PatientCreate.fromJson(response.data);
      } else {
        print(response.data);
        throw Exception('Failed to create patient');
      }
    } catch (e, strack) {
      print("strack:e:$e");
      print("strack:$strack");
      throw Exception('Failed to create patient throw catch');
    }
  }

  Future<void> deletePatient(String id) async {
    await fetchToken();
    try {
      final response = await HttpService.delete(
        ApiEndPoint.deletePatientById(id: id),
        token,
      );
      if (response.statusCode == 200) {
        print(response.data);
        if (kDebugMode) {
          print('Delete Patient successful');
        }
      } else {
        if (kDebugMode) {
          print(
              'Delete Patient request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Delete Patient Error: $e');
      }
    }
  }

  Future<PatientByIdModel> getPatientById(String id) async {
    await fetchToken();
    final response = await HttpService.get(
      ApiEndPoint.getPatientById(id: id),
      token,
    );
    log("patient details >>>>>>>>>> " + response.toString());
    if (response.statusCode == 200) {
      final data = response.data;
      return PatientByIdModel.fromJson(data);
    } else {
      throw Exception('Failed to load patients: ${response.statusCode}');
    }
  }

  Future<PatientModel?> getFullPatientRecord(String id) async {
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
  }
}
