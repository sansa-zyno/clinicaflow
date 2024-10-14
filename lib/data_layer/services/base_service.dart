
import 'package:healtether_clinic_app/data_layer/api_client.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/file_model.dart';

abstract class BaseService {
  const BaseService([this.apiClient = const ApiClient()]);

  final ApiClient apiClient;

  /// Extracts the actual response models  that can be returned from
  /// the api call Map<String, dynamic> response.
  dynamic extractMessage(dynamic response);

  // //? MAKE REQUEST
  dynamic makeRequest(
      {required String endpoint,
      String? token,
      String? baseUrl,
      Map<String, dynamic>? body,
      String method = 'POST'}) async {
    final response = await ApiClient.makeRequest(
        endpoint: endpoint, baseUrl: baseUrl, body: body ?? {}, token: token, method: method);

    print("RECIEVED RESPONSE: $response");
    return extractMessage(response);
  }

  //? MAKE REQUEST
  dynamic makeMultipartRequest(
      {required String endpoint,
      required String token,
      Map<String, String>? body,
      File? file,
      List<File>? files,
      String method = 'POST'}) async {
    // final response = {"success": true};
    final response = await ApiClient.makeMultiPartRequest(
        endpoint: endpoint, file: file, files: files, body: body ?? {}, token: token, method: method);

    print(response);
    return extractMessage(response);
  }
}