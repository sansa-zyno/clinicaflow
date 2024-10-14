import 'dart:convert';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class CreateSymptomsService {
  String token = "";

  Future<String?> fetchToken() async {
    return token = (await SharedPrefService.getAccessToken())!;
  }

  Future<Map<String, dynamic>> createSymptoms(String searchText,
      List<String> selectedSymptoms, List<String> selectedDiagnoses) async {
    print("Token: $token");

    final response = await HttpService.post(
      ApiEndPoint.createSymptoms,
      token,
      {
        "input_symptoms": selectedSymptoms,
        "input_diagnoses": selectedDiagnoses,
        "n_diseases": 3,
        "n_symptoms": 3,
        "min_symptoms": 1
      },
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.data}");

    if (response.statusCode == 200) {
      final data = response.data;
      print("Decoded response: $data");

      if (data.containsKey('search_output')) {
        final searchOutput = data['search_output'];
        print("Search output: $searchOutput");

        final symptomsList = searchOutput['symptoms'] as List<dynamic>?;
        final diagnosesList = searchOutput['diagnoses'] as List<dynamic>?;
        final associatedSymptomsList =
            data['associated Symptoms'] as List<dynamic>?;
        final differentialDiagnosesList =
            data['differential Diagnoses'] as List<dynamic>?;

        return {
          'symptoms': symptomsList?.cast<String>() ?? [],
          'diagnoses': diagnosesList?.cast<String>() ?? [],
          'associatedSymptoms': associatedSymptomsList?.cast<String>() ?? [],
          'differentialDiagnoses':
              differentialDiagnosesList?.cast<String>() ?? [],
        };
      } else {
        throw Exception('Missing "search_output" key in response');
      }
    } else {
      throw Exception(
          'Failed to create symptoms (Status code: ${response.statusCode})');
    }
  }
}
