import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vitals_response.dart';
import 'package:healtether_clinic_app/data_layer/services/base_service.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

/// This communicates with the api client, gets data from api and converts
/// it into dart objects (models) that can be used in the app
class VitalsService extends BaseService {
  @override
  dynamic extractMessage(dynamic response) {
    if (response is AppError) return response;

    log("Vital response: $response");

    final vitals = response['list']
        ?.map((e) => Vital.fromMap(e as Map<String, dynamic>))
        .toList();

    // log("vitals: ${vitals.map((e) => e.id).toList()}, runtimetype: ${vitals.runtimeType}");

    if (response['success'] == true) {
      response = VitalsResponse(success: true, vitals: List<Vital>.from(vitals));
      return response;
    } else {
      return AppError.errorObject(response);
    }
  }
}
