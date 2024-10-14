import 'dart:convert';
import 'dart:developer';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class AnalyticsService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

//patient analysis
  Future<List<dynamic>> fetchAgeRatio(Map<String, String> myBody) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.getAgeRatio,
      token,
      myBody,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<List<dynamic>> fetchPatientRatio(Map<String, String> myBody) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.getPatientRatio,
      token,
      myBody,
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<dynamic>> fetchGenderRatio(Map<String, String> myBody) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.getGenderRatio,
      token,
      myBody,
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  //appointment analysis
  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://9316dbec-7490-466d-bc74-5e4bb14eefc2.mock.pstmn.io/'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
}
