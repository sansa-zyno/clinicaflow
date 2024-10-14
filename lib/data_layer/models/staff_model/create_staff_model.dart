import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/appointment_slot.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/address_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/document_staff_model.dart';

class CreateStaff {
  String? staffId;
  String? firstName;
  String? lastName;
  String? specialisation;
  String? isDoctor;
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
  String? isAdmin;
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
      this.isAdmin,
      this.createdOn,
      this.modifiedOn,
      this.profilepic,
      this.documents,
      this.availableTimeSlot,
      this.clientId});

  CreateStaff.fromJson(Map<String, dynamic> json) {
    staffId = json['staffId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    specialisation = json['specialisation'];
    isDoctor = json['isDoctor'];
    age = json['age'];
    birthday = json['birthday'];
    gender = json['gender'];
    mobile = json['mobile'];
    email = json['email'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    documentType = json['documentType'];
    documentNumber = json['documentNumber'];
    bankName = json['bankName'];
    account = json['account'];
    accountName = json['accountName'];
    ifsc = json['ifsc'];
    isAdmin = json['isAdmin'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    profilepic = json['profilepic'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
    if (json['availableTimeSlot'] != null) {
      availableTimeSlot = <AppointmentSlot>[];
      json['availableTimeSlot'].forEach((v) {
        availableTimeSlot!.add(AppointmentSlot.fromMap(v));
      });
    }
    clientId = json['clientId'];
  }

  Map<String, dynamic> toJson(BuildContext context) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staffId'] = staffId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['specialisation'] = specialisation;
    data['isDoctor'] = isDoctor;
    data['age'] = age;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['email'] = email;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['documentType'] = documentType;
    data['documentNumber'] = documentNumber;
    data['bankName'] = bankName;
    data['account'] = account;
    data['accountName'] = accountName;
    data['ifsc'] = ifsc;
    data['isAdmin'] = isAdmin;
    data['createdOn'] = createdOn;
    data['modifiedOn'] = modifiedOn;
    data['profilepic'] = profilepic;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (availableTimeSlot != null) {
      data['availableTimeSlot'] =
          "${availableTimeSlot!.map((v) => v.toJson(context)).toList()}";
    }
    data['clientId'] = clientId;
    return data;
  }
}
