import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';
import 'package:healtether_clinic_app/constants/api.dart';
import 'package:healtether_clinic_app/data_layer/services/http.service.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class StaffServices {
  String token = "";
  String clinicId = "";
  Future<void> fetchToken() async {
    token = await SharedPrefService.getAccessToken() ?? "";
    clinicId = await SharedPrefService.getClinicId() ?? "";
  }

  Future<String> getStaffId() async {
    await fetchToken();
    final response = await HttpService.get(
      ApiEndPoint.getStaffId(clinicId: clinicId),
      token,
    );
    if (response.statusCode == 200) {
      if (response.data['staffId'] != null) {
        String prefix = response.data['staffId']['prefix'];
        String suffix = response.data['staffId']['suffix'];
        String currentStaffId = (response.data['staffId']['currentStaffId'] as int).toString();
        return '${prefix}_${currentStaffId}_$suffix';
      } else {
        throw Exception('Failed to create staff id: ${response.statusCode}');
      }
    } else {
      throw Exception('Failed to create staff id: ${response.statusCode}');
    }
  }

  Future<String> createStaff(CreateStaff createStaff, BuildContext context) async {
    await fetchToken();
    Map<String, dynamic> map = createStaff.toJson(context);
    String staffId = await getStaffId();
    map['staffId'] = staffId;
    log('staffId  ${map['staffId']}');
    final response = await HttpService.post(
      ApiEndPoint.createStaff,
      token,
      {"data": map},
    );
    log("res:::::${response.data}");
    if (response.statusCode == 200) {
      return response.data['description'];
    } else {
      throw Exception('Failed to create staff');
    }
  }

  Future<String> updateStaff(CreateStaff createStaff, BuildContext context, String id) async {
    await fetchToken();
    Map<String, dynamic> map = createStaff.toJson(context);
    map.addAll({'id': id});
    final response = await HttpService.post(
      ApiEndPoint.createStaff,
      token,
      {"data": map},
    );
    log("res:::::${response.data}");
    if (response.statusCode == 200) {
      return response.data['description'];
    } else {
      throw Exception('Failed to create staff');
    }
  }

  Future<List<Staff>> fetchStaffs() async {
    await fetchToken();
    try {
      final response = await HttpService.get(ApiEndPoint.getStaffs(clinicId: clinicId), token);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        if (jsonResponse.containsKey('data')) {
          List<dynamic> dataList = jsonResponse['data'];
          List<Staff> staffList = dataList.map((json) => Staff.fromJson(json)).toList();
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

  Future<StaffByIdModel> getStaffById(String id) async {
    await fetchToken();
    log("ID : $id");
    final response = await HttpService.get(
      ApiEndPoint.getStaffById(id: id),
      token,
    );
    log("res:::::${response.data}");
    if (response.statusCode == 200) {
      return StaffByIdModel.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch staff detail');
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
          print('Delete Staff request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Delete Staff Error: $e');
      }
    }
  }
}
