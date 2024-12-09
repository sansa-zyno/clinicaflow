import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/appointment_slot.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/address_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/document_staff_model.dart';

class CreateStaff {
  String? staffId;
  String? firstName;
  String? lastName;
  String? specialisation;
  bool? isDoctor;
  String? age;
  String? birthday;
  String? gender;
  String? mobile;
  String? email;
  Address? address;
  String? documentType;
  String? documentNumber;
  String? bankName;
  String? account;
  String? accountName;
  String? ifsc;
  String? upiId;
  String? createdOn;
  String? modifiedOn;
  String? profilepic;
  List<Documents>? documents;
  List<AppointmentSlot>? availableTimeSlot;
  String? clientId;

  CreateStaff(
      {this.staffId,
      this.firstName,
      this.lastName,
      this.specialisation,
      this.isDoctor,
      this.age,
      this.birthday,
      this.gender,
      this.mobile,
      this.email,
      this.address,
      this.documentType,
      this.documentNumber,
      this.bankName,
      this.account,
      this.accountName,
      this.ifsc,
      this.upiId,
      this.createdOn,
      this.modifiedOn,
      this.profilepic,
      this.documents,
      this.availableTimeSlot,
      this.clientId});

  Map<String, dynamic> toJson(BuildContext context) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staffId'] = staffId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['specialization'] = specialisation ?? '';
    data['isDoctor'] = isDoctor ?? false;
    data['age'] = int.tryParse(age ?? '0') ?? 0;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['email'] = email ?? '';
    if (address != null) {
      data['address'] = address!.toJson();
    } else {
      data['address'] = Address().toJson();
    }
    data['documentType'] = documentType ?? '';
    data['documentNumber'] = documentNumber ?? '';
    data['upiId'] = upiId ?? '';
    data['bankName'] = bankName ?? '';
    data['accountName'] = accountName ?? '';
    data['account'] = account ?? '';
    data['ifsc'] = ifsc ?? '';
    /* if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    } else {
      data['documents'] = [];
    }*/
    if (availableTimeSlot != null) {
      data['availableTimeSlot'] = "${availableTimeSlot!.map((v) => v.toJson(context)).toList()}";
    } else {
      data['availableTimeSlot'] = "[]";
    }
    data['clientId'] = clientId;
    return data;
  }
}
