import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/allergies/allergies.dart';
import 'package:healtether_clinic_app/data_layer/models/allergies/allergies_response.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/services/base_service.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

class AllergyService extends BaseService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  @override
  extractMessage(response) {
    log("RESPONSE TO EXTRACT: $response");

    if (response is AppError) return response;

    if (response['success'] == true) {
      return AllergyResponse(
          success: response['success'] == true,
          message: response['message'],
          allergies: response['list'] != null ? allergies(response['list']) : null,
          allergy: response['allergy']);
    } else {
      return AppError.errorObject(response);
    }
  }

  List<Allergy> allergies(List<dynamic> response) {
    return response.map((e) => Allergy.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<List<Allergy>> searchAllergies(String query) async {
    await fetchToken();

    final response = await HttpService.get(ApiEndPoint.searchAllergies(query: query), token);
    log(response.data.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      List<Allergy> allergies = (jsonResponse['data'] as List).map((map) => Allergy.fromMap(map)).toList();

      return allergies;
    } else {
      throw 'Failed to load data: ${response.statusCode}';
    }
  }
}
