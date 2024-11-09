import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vitals_response.dart';
import 'package:healtether_clinic_app/data_layer/services/base_service.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

/// This communicates with the api client, gets data from api and converts
/// it into dart objects (models) that can be used in the app
class VitalsService extends BaseService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  @override
  dynamic extractMessage(dynamic response) {
    if (response is AppError) return response;

    log("Vital response: $response");

    final vitals = response['list']?.map((e) => Vital.fromMap(e as Map<String, dynamic>)).toList();

    // log("vitals: ${vitals.map((e) => e.id).toList()}, runtimetype: ${vitals.runtimeType}");

    if (response['success'] == true) {
      response = VitalsResponse(success: true, vitals: List<Vital>.from(vitals));
      return response;
    } else {
      return AppError.errorObject(response);
    }
  }

  Future<String> postVitals({required String patientId, required String appointmentId, required Map vitals}) async {
    await fetchToken();
    final response = await HttpService.post(
      ApiEndPoint.postVitals(patientId: patientId, clientId: clinicId, appointmentId: appointmentId),
      token,
      {"vitals": vitals},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw 'Failed to save data: ${response.statusCode}';
    }
  }

  /*  Future<List<LabTest>?> getVitals({required String appointmentId}) async {
    await fetchToken();
    final response = await HttpService.get(ApiEndPoint.getWholePrescriptionsAndVitals(appointmentId: appointmentId, clientId: clinicId), token);
    if (response.statusCode == 200) {
      if (response.data['prescriptions'] != null) {
        List<LabTest>? labTests = (response.data['prescriptions']['labTests'] as List?)?.map((e) => LabTest.fromMap(e)).toList();
        return labTests;
      } else {
        return null;
      }
    } else {
      throw 'Failed to retrieve data: ${response.statusCode}';
    }
  }*/
}
