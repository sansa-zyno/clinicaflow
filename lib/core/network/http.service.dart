import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';

class HttpService {
  static String host = ApiEndPoint.baseUrl;
  static Dio dio = Dio();

  //for get api calls
  static Future<Response> get(
    String url,
    String token, {
    Map<String, dynamic>? queryParameters,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    log(url);
    return dio.get(uri,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
        ));
  }

  //for post api calls
  static Future<Response> post(
    String url,
    String token,
    body, {
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    log(url);
    return dio.post(uri,
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
        ));
  }

  //for post api calls with file upload
  static Future<Response> postWithFiles(
    String url,
    String token,
    body,
  ) async {
    //preparing the api uri/url
    String uri = "$host$url";
    log(url);
    Response response;
    try {
      response = await dio.post(uri,
          data: FormData.fromMap(body),
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
          ));
    } catch (error) {
      response = error as Response;
    }

    return response;
  }

  //for patch api calls
  /*Future<Response> patch(String url, Map<String, dynamic> body) async {
    String uri = "$host$url";
    return dio.patch(
      uri,
      data: body,
      options: Options(
        headers: await getHeaders(),
      ),
    );
  }*/

  //for delete api calls
  static Future<Response> delete(
    String url,
    String token, {
    Map<String, dynamic>? queryParameters,
  }) async {
    String uri = "$host$url";
    log(url);
    return dio.delete(uri,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
        ));
  }

  /*Response formatDioExecption(DioError ex) {
    var response = Response(requestOptions: ex.requestOptions);
    response.statusCode = 400;
    try {
      if (ex.type == DioErrorType.connectTimeout) {
        response.data = {
          "message":
              "Connection timeout. Please check your internet connection and try again",
        };
      } else {
        response.data = {
          "message": ex.message ??
              "Please check your internet connection and try again",
        };
      }
    } catch (error) {
      response.statusCode = 400;
      response.data = {
        "message": error.message ??
            "Please check your internet connection and try again",
      };
    }

    return response;
  }*/
}
