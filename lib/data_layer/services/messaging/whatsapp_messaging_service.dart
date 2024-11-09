import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class WhatSappMessagingService {
  String clinicId = "";
  Future<void> fetchClinic() async {
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('CLINIC_ID ' + clinicId);
  }

  Future<bool> sendWhatsappMsg({required String phoneNo, required String message}) async {
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
  }
}
