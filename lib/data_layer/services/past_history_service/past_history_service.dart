import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/past_history/past_history.dart';
import 'package:healtether_clinic_app/data_layer/models/past_history/past_history_response.dart';
import 'package:healtether_clinic_app/data_layer/services/base_service.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

class PastHistoryService extends BaseService {
  @override
  dynamic extractMessage(dynamic response) {

    log("RESPONSE TO EXTRACT: $response");

    if (response is AppError) return response;

    if (response['success'] == true) {
      return PastHistoryResponse(
          success: response['success'] == true,
          pastHistory: response['past_history'] != null
              ? PastHistory.fromMap(response['past_history'])
              : null,
          pastHistories:
              response['list'] != null ? histories(response['list']) : null,
          message: response['message']);
    } else {
      return AppError.errorObject(response);
    }
  }

  List<PastHistory> histories(List<dynamic> response) {
    return response
        .map((e) => PastHistory.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
