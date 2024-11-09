import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import '../shared_preferences_service.dart';
import '../../models/payment_models/payment_response_model.dart';

class PaymentService {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  Future<List<GetPayment>> fetchPayment() async {
    await fetchToken();
    final response = await HttpService.get(ApiEndPoint.getPayments(clinicId: clinicId), token);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      if (jsonResponse.containsKey('data')) {
        List<dynamic> paymentList = jsonResponse['data'];
        List<GetPayment> payments = paymentList.map((json) => GetPayment.fromJson(json)).toList();
        return payments;
      } else {
        throw 'Key "data" not found in response';
      }
    } else {
      throw 'Failed to load payments: ${response.statusCode}';
    }
  }
}
