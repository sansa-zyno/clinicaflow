import 'dart:async';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/file_model.dart';
import 'package:healtether_clinic_app/constants/network_constants.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'dart:convert';

class ApiClient {
  const ApiClient();
  static makeRequest({
    required String endpoint,
    String? baseUrl,
    String? token,
    String method = 'POST',
    required Map<String, dynamic> body,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String url = '${baseUrl ?? NetworkConstants.baseUrl}/$endpoint';

    log("REQUEST URL: $url");

    final String? scheme = baseUrl?.split('://')[0];
    final String? host = baseUrl?.split('://')[1].split(':')[0];
    final String? port = baseUrl?.split('://')[1].split(':')[1];

    log("sheme, host, port, path: $scheme, $host, $port, $endpoint");

    var request = http.Request(
        method.toUpperCase(),
        baseUrl != null
            ? Uri(
                scheme: scheme,
                host: host,
                port: int.tryParse(port ?? ''),
                path: endpoint)
            : Uri.parse(url));

    request.body = json.encode(body);
    request.headers.addAll(headers);

    log("endpoint, token, body: $endpoint, $token, $body");

    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: NetworkConstants.timeout),
            onTimeout: _onTimeout,
          );
      String responseStr = await response.stream.bytesToString();

      // log("R E S P O N S E S T R   $responseStr");

      final responseObj = jsonDecode(responseStr);

      final formattedResponse = _formatResponse(response, responseObj);

      log("FINAL RESPONSE OBJECT: $formattedResponse");

      return formattedResponse;
    } catch (e) {
      // TODO
      // log(":::::::: e is $e");
      return AppError.handleError(e);
    }
  }

  static makeMultiPartRequest(
      {required String token,
      required String endpoint,
      required String method,
      required Map<String, String> body,
      File? file,
      List<File>? files}) async {
    //? SETUP REQUEST HEADER
    var headers = {'Authorization': 'Bearer $token'};

    //? SETUP URL
    final Uri url = Uri.parse('${NetworkConstants.baseUrl}/$endpoint');

    //? INITIALIZE MULTI-PART REQUEST
    var request = http.MultipartRequest(method.toUpperCase(), url);

    //? ADD REQUEST BODY
    request.fields.addAll(body);

    //? ADD ANY FILES
    // String? contentType;

    // if (file != null) contentType = file.headers?['Content-Type'];

    MediaType? mediaType;
    // if (contentType != null) {
    //   mediaType =
    //       MediaType(contentType.split('/')[0], contentType.split('/')[1]);
    // }
    try {
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
            file.name, file.path,
            contentType: mediaType));
      }
      if (files != null && files.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          request.files.add(
              await http.MultipartFile.fromPath(files[i].name, files[i].path));
        }
      }

      // log("::: R E Q U E S T   F I L E S   ${request.files} :::");
      log("::: R E Q U E S T   F I L E S   ${request.files.first.contentType} :::");
    } catch (e) {
      log(e);
    }

    request.headers.addAll(headers);

    // if (file != null && file.headers != null)
    //   request.headers.addAll(file.headers!);

    // log(":::::Headers: ${request.headers}");

    try {
      http.StreamedResponse response = await request.send().timeout(
            const Duration(milliseconds: NetworkConstants.timeout),
            onTimeout: _onTimeout,
          );

      dynamic responseObj = jsonDecode(await response.stream.bytesToString());

      return _formatResponse(response, responseObj);
    } catch (e) {
      return AppError.handleError(e);
    }
  }

  //? H E L P E R   M E T H O D S
  static FutureOr<http.StreamedResponse> _onTimeout() {
    const timeoutResponse = {
      "status": "fail",
      "msg": "Request timeout. please check your internet connection"
    };

    List<int> byte = utf8.encode(jsonEncode(timeoutResponse));

    Stream<List<int>> byteStream = Stream.fromIterable([byte]);

    return http.StreamedResponse(byteStream, 400,
        headers: NetworkConstants.defaultHeader);
  }

  static dynamic _formatResponse(http.StreamedResponse response, responseObj) {
    log("RESPONSE OBJECT IS List?: ${responseObj.runtimeType == List<dynamic>}");
    log("RESPONSE OBJECT IS Map?: ${responseObj.runtimeType == Map<String, dynamic>}");
    log("RESPONSE OBJECT TYPE: ${responseObj.runtimeType}");

    log("before list");

    if (responseObj.runtimeType == List<dynamic>) {
      final map = {
        "success": response.statusCode.toString().startsWith('2'),
        "list": responseObj
      };
      log("map: $map");
      log("after list");
      return map;
    } else {
      responseObj['success'] = response.statusCode.toString().startsWith('2');
      return responseObj;
    }
  }

  // static void _extractToken(http.StreamedResponse response, responseObj) {
  //   if (responseObj is Map<String, dynamic> && responseObj['token'] != null) {
  //     responseObj['token'] = response.headers['token'];
  //   }
  // }
}
