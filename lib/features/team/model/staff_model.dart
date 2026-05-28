import 'package:flutter/material.dart';
import 'package:clinica_flow/features/appointment/model/appointment_slot.dart';
import 'package:clinica_flow/shared/models/address_model.dart';

import '../../../shared/models/created_model.dart';
import '../../../shared/models/document_model.dart';

class StaffModel {
  StaffModel(
      {this.id,
      this.staffId,
      this.profilepic,
      this.firstName,
      this.lastName,
      this.specialization,
      this.isDoctor,
      this.age,
      this.birthday,
      this.gender,
      this.mobile,
      this.email,
      this.address,
      this.documentType,
      this.documentNumber,
      this.documents,
      this.bankName,
      this.accountNo,
      this.accountName,
      this.availableTimeSlot,
      this.createdOn,
      this.modifiedOn,
      this.clientId});

  String? id;
  String? staffId;
  String? profilepic;
  String? firstName;
  String? lastName;
  String? specialization;
  bool? isDoctor;
  int? age;
  DateTime? birthday;
  String? gender;
  String? mobile;
  String? email;
  Address? address;
  String? documentType;
  String? documentNumber;
  List<Documents>? documents;
  String? bankName;
  String? accountNo;
  String? accountName;
  List<AppointmentSlot>? availableTimeSlot;
  Created? createdOn;
  Created? modifiedOn;
  String? clientId;

  StaffModel copyWith(
      {String? id,
      String? staffId,
      String? profilepic,
      String? firstName,
      String? lastName,
      String? specialization,
      bool? isDoctor,
      int? age,
      DateTime? birthday,
      String? gender,
      String? mobile,
      String? email,
      Address? address,
      String? documentType,
      String? documentNumber,
      List<Documents>? documents,
      String? bankName,
      String? accountNo,
      String? accountName,
      List<AppointmentSlot>? availableTimeSlot,
      Created? createdOn,
      Created? modifiedOn,
      String? clientId}) {
    return StaffModel(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      profilepic: profilepic ?? this.profilepic,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      specialization: specialization ?? this.specialization,
      isDoctor: isDoctor ?? this.isDoctor,
      age: age ?? this.age,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      address: address ?? this.address,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      documents: documents ?? this.documents,
      bankName: bankName ?? this.bankName,
      accountNo: accountNo ?? this.accountNo,
      accountName: accountName ?? this.accountName,
      availableTimeSlot: availableTimeSlot ?? this.availableTimeSlot,
      createdOn: createdOn ?? this.createdOn,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      clientId: clientId ?? this.clientId,
    );
  }

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json["id"] ?? "",
      staffId: json["staffId"] ?? "",
      profilepic: json["profilePic"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      specialization: json["specialization"] ?? "",
      isDoctor: json["isDoctor"] ?? false,
      age: json["age"] ?? 0,
      birthday: DateTime.tryParse(json["birthday"] ?? ""),
      gender: json["gender"] ?? "",
      mobile: json["mobile"] ?? "",
      email: json["email"] ?? "",
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      documentType: json["documentType"] ?? "",
      documentNumber: json["documentNumber"] ?? "",
      documents: json["documents"] == null
          ? []
          : List<Documents>.from(
              json["documents"]!.map((x) => Documents.fromJson(x))),
      bankName: json["bankName"] ?? "",
      accountNo: json["accountNo"] ?? "",
      accountName: json["accountName"] ?? "",
      availableTimeSlot: json["availableTimeSlot"] == null
          ? []
          : List<AppointmentSlot>.from(json["availableTimeSlot"]!
              .map((x) => AppointmentSlot.fromJson(x))),
      createdOn:
          json["created"] == null ? null : Created.fromJson(json["created"]),
      modifiedOn:
          json["modified"] == null ? null : Created.fromJson(json["modified"]),
      clientId: json["clientId"] ?? "",
    );
  }

  Map<String, dynamic> toJson(BuildContext context) => {
        "id": id,
        "staffId": staffId,
        "profilePic": profilepic,
        "firstName": firstName,
        "lastName": lastName,
        "specialization": specialization,
        "isDoctor": isDoctor,
        "age": age,
        "birthday": birthday?.toIso8601String(),
        "gender": gender,
        "mobile": mobile,
        "email": email,
        "address": address != null ? address?.toJson() : Address().toJson(),
        "documentType": documentType,
        "documentNumber": documentNumber,
        "documents": documents != null ? documents!.map((x) => x).toList() : [],
        "bankName": bankName,
        "accountNo": accountNo,
        "accountName": accountName,
        "availableTimeSlot": availableTimeSlot != null
            ? availableTimeSlot!.map((x) => x.toJson(context)).toList()
            : [],
        "created": createdOn?.toJson(),
        "modified": modifiedOn?.toJson(),
        'clientId': clientId
      };

  @override
  String toString() {
    return "$id, $staffId, $profilepic, $firstName, $lastName, $specialization, $isDoctor, $age, $birthday, $gender, $mobile,  $email, $address, $documentType, $documentNumber,$documents, $bankName, $accountName, $availableTimeSlot, $createdOn, $modifiedOn, $clientId ";
  }
}
