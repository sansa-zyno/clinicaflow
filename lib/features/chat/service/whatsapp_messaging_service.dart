import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/core/network/http.service.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';

class WhatSappMessagingService {
  String clinicId = "";
  Future<void> fetchClinic() async {
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<bool> sendWhatsappMsg(
      {required String phoneNo, required String message}) async {
    await fetchClinic();
    log('${ApiEndPoint.msgBaseUrl}/${ApiEndPoint.sendWhatsappMsg}');
    final response = await HttpService.dio
        .post('${ApiEndPoint.msgBaseUrl}/${ApiEndPoint.sendWhatsappMsg}',
            data: {
              "data": {
                "message": message,
                "mobile": phoneNo,
                "clinicId": clinicId,
              }
            },
            options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
            ));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Failed to send message: ${response.statusCode}';
    }
  }

  /*Future<bool> sendAppointmentSummary({
    required String phoneNo,
    required String clinicName,
    required String patientName,
    required String doctorName,
    required String scheduleDate,
    required String timeSlots,
  }) async {
    await fetchClinic();
    log('${ApiEndPoint.msgBaseUrl}/${ApiEndPoint.sendWhatsappMsg}');
    final response = await HttpService.dio.post('${ApiEndPoint.msgBaseUrl}/${ApiEndPoint.sendWhatsappMsg}',
        data: {
          "data": {
            "message": message,
            "mobile": phoneNo,
            "clinicId": clinicId,
          }
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Failed to send message: ${response.statusCode}';
    }
  }*/
}
