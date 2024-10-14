import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/past_procedure/past_procedure.dart';
import 'package:healtether_clinic_app/data_layer/models/past_procedure/past_procedure_response.dart';
import 'package:healtether_clinic_app/data_layer/services/base_service.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

class PastProcedureService extends BaseService {
  @override
  extractMessage(response) {
    log("RESPONSE TO EXTRACT: $response");

    if (response is AppError) return response;

    if (response['success'] == true) {
      return PastProcedureResponse(
          success: response['success'] == true,
          message: response['message'],
          pastProcedures:
              response['list'] != null ? procedures(response['list']) : null,
          pastProcedure: response['pastProcedure']);
      
    } else {
      return AppError.errorObject(response);
    }
  }

  List<PastProcedure> procedures(List<dynamic> response) {
    return response
        .map((e) => PastProcedure.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
