/*import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';

class CreateStaffResponse {
  CreateStaff? createStaff;

  CreateStaffResponse({this.createStaff});

  CreateStaffResponse.fromJson(Map<String, dynamic> json) {
    createStaff = json['createStaff'] != null
        ? CreateStaff.fromJson(json['createStaff'])
        : null;
  }

  Map<String, dynamic> toJson(BuildContext context) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (createStaff != null) {
      data['createStaff'] = createStaff!.toJson(context);
    }
    return data;
  }
}*/
