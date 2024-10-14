import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_request_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class StaffServices {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
    log('TOKEN ' + token);
    log('CLINIC_ID ' + clinicId);
  }

  Future<List<Staff>> fetchStaffs() async {
    await fetchToken();

    try {
      final response = await HttpService.get(
          ApiEndPoint.getStaffs(clinicId: clinicId), token);
      log(response.data.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;

        if (jsonResponse.containsKey('data')) {
          List<dynamic> dataList = jsonResponse['data'];
          List<Staff> staffList =
              dataList.map((json) => Staff.fromJson(json)).toList();
          return staffList;
        } else {
          throw 'Key "data" not found in response';
        }
      } else {
        throw 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load data: $e';
    }
  }

  Future<void> deleteStaff(String id) async {
    await fetchToken();
    try {
      final response = await HttpService.delete(
        ApiEndPoint.deleteStaffById(id: id),
        token,
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Delete Staff successful');
        }
      } else {
        if (kDebugMode) {
          print(
              'Delete Staff request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Delete Staff Error: $e');
      }
    }
  }

  Future<CreateStaffResponse> createStaff(
      CreateStaff createStaff, BuildContext context) async {
    await fetchToken();

    final response = await HttpService.post(
      ApiEndPoint.createStaff,
      token,
      // body: json.encode(createStaff.toJson()),
      {"data": createStaff.toJson(context)},
    );
    log("res:::::${response.data}");
    log("status code>>>>>" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return CreateStaffResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to create staff');
    }
  }

  Future<StaffByIdModel> getStaffById(String id) async {
    await fetchToken();
    print("ID : $id");

    final response = await HttpService.get(
      ApiEndPoint.getStaffById(id: id),
      token,
    );
    print("res ::::::: ${response.statusCode}");
    log("res:::::${response.data}");
    if (response.statusCode == 200) {
      return StaffByIdModel.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch staff detail');
    }
  }
}
