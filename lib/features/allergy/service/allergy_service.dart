import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/features/allergy/model/allergies.dart';
import 'package:clinica_flow/core/network/http.service.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';

class AllergyService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  List<Allergy> allergies(List<dynamic> response) {
    return response
        .map((e) => Allergy.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Allergy>> searchAllergies(String query) async {
    await fetchToken();

    final response =
        await HttpService.get(ApiEndPoint.searchAllergies(query: query), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Allergy> allergies = (jsonResponse['data'] as List)
          .map((map) => Allergy.fromMap(map))
          .toList();

      return allergies;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }
}
