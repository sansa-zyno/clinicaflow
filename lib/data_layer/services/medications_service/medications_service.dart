import 'dart:convert';
import 'dart:developer';

import 'package:healtether_clinic_app/data_layer/models/create_medications/create_medications_model.dart';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class MedicationsService {
  String token = "";

  Future<String?> fetchToken() async {
    return token = (await SharedPrefService.getAccessToken())!;
  }

  Future<CreateMedications?> createMedications(CreateMedications createMedications) async {
    await fetchToken();
    print("Token: $token");

    final response = await HttpService.post(
      ApiEndPoint.postMedicationDdx,
      token,
      jsonEncode(createMedications.toJson()),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.data}");

    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      return CreateMedications.fromJson(jsonResponse);
    } else {
      print('Failed to post medications: ${response.data}');
      return null;
    }
  }

  Future<List<Drug>> searchDrugs(String query) async {
    await fetchToken();

    final response = await HttpService.get(ApiEndPoint.searchDrugs(query: query), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Drug> drugs = (jsonResponse['data'] as List).map((map) => Drug.fromMap(map)).toList();

      return drugs;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }
}
